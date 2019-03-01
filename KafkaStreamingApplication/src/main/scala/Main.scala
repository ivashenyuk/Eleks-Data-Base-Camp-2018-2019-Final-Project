import java.sql.{Connection, DriverManager, SQLException, Statement}
import java.time.Duration
import java.util.{Collections, Properties}

import Entities.{Event, Player}

import com.sksamuel.avro4s.RecordFormat
import io.confluent.kafka.serializers.AbstractKafkaAvroSerDeConfig
import io.confluent.kafka.streams.serdes.avro.{GenericAvroDeserializer, GenericAvroSerde, GenericAvroSerializer}
import net.liftweb.json.Serialization.write
import net.liftweb.json._
import org.apache.avro.generic.GenericRecord
import org.apache.kafka.clients.consumer.ConsumerConfig
import org.apache.kafka.clients.producer.ProducerConfig
import org.apache.kafka.common.serialization.{Serde, Serdes}
import org.apache.kafka.streams.kstream._
import org.apache.kafka.streams.{KafkaStreams, KeyValue, StreamsBuilder, StreamsConfig}

import scala.collection.JavaConverters._
import scala.collection.mutable._

object Main {

  val serverIP: String = "35.231.61.130"
  val props: Properties = {
    val p = new Properties()
    p.put(StreamsConfig.APPLICATION_ID_CONFIG, "Streaming-Application")
    p.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, serverIP.concat(":9092"))
    p.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass.getName)
    //    p.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass.getName)
    p.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, classOf[GenericAvroSerde])
    p.put(AbstractKafkaAvroSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, "http://35.231.61.130:8081")
    //    p.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest")
    p
  }
  val valueFormatter = RecordFormat[Event]
  val valueFormatterPlayer = RecordFormat[Player]
  val STATISTIC_TOPIC_NAME = "StatisticByCards"
  val DATA_TOPIC_NAME = "Events"
  val connectionUrl: String = "jdbc:sqlserver://34.73.142.102:1433;databaseName=BookmakerOLTP;user=sa;password=SQLServer2016"

  def main(args: Array[String]): Unit = {
    val builder: StreamsBuilder = new StreamsBuilder()

    val urlRegistrySchema = "http://".concat(serverIP.concat(":8081"))

    val avroSerde: Serde[GenericRecord] = new GenericAvroSerde()
    avroSerde.configure(
      Collections
        .singletonMap(AbstractKafkaAvroSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, urlRegistrySchema), true)

    val config = Map(
      ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG -> "io.confluent.kafka.serializers.KafkaAvroSerializer",
      ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG -> "io.confluent.kafka.serializers.KafkaAvroSerializer",
      ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG -> "io.confluent.kafka.serializers.KafkaAvroDeserializer",
      ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG -> "io.confluent.kafka.serializers.KafkaAvroDeserializer",
      "schema.registry.url" -> urlRegistrySchema).asJava

    val avroSerdePlayer = Serdes.serdeFrom({
      val ser = new GenericAvroSerializer()
      ser.configure(config, false)
      ser
    }, {
      val de = new GenericAvroDeserializer()
      de.configure(config, false)
      de
    })

    val eventsStream: KStream[String, GenericRecord] =
      builder
        .stream[String, GenericRecord](DATA_TOPIC_NAME, Consumed.`with`(Serdes.String(), avroSerde))

    val goalStreamPredicate = new Predicate[String, GenericRecord] {
      override def test(t: String, c: GenericRecord): Boolean = {
        val event = valueFormatter.from(c)
        event.DescriptionEvent == "Goal"
      }
    }
    val cardStreamPredicate = new Predicate[String, GenericRecord] {
      override def test(t: String, c: GenericRecord): Boolean = {
        val event = valueFormatter.from(c)
        event.DescriptionEvent.contains("Card")
      }
    }
    val startStreamPredicate = new Predicate[String, GenericRecord] {
      override def test(t: String, c: GenericRecord): Boolean = {
        val event = valueFormatter.from(c)
        event.DescriptionEvent == "Started"
      }
    }

    val splittedStreams = eventsStream.branch(goalStreamPredicate, startStreamPredicate, cardStreamPredicate)

    val goalStream = splittedStreams(0)
    val startedStream = splittedStreams(1)
    val cardStream = splittedStreams(2)

    val calculated: KTable[Windowed[String], java.lang.Long] = cardStream
      .groupBy((_, value) => {
        println("Event value => " + value)
        val event = valueFormatter.from(value)
        event.DescriptionEvent
      })
      .windowedBy(TimeWindows.of(Duration.ofMinutes(1)))
      .count()

    calculated
      .toStream
      .map[String, AnyRef]((k, v) => {
      val arrEventValues = k.key().split(";")
      val card = arrEventValues(0).trim
      val name = arrEventValues(1).trim
      val clubName = arrEventValues(2).trim

      val player = Player(k.key(), card, name, clubName, v)
      val record = valueFormatterPlayer.to(player)
      implicit val formats = DefaultFormats
      val jsonString = write(player)
      println("Sent result => " + jsonString.toString)
      KeyValue.pair(k.key(), record)
    }).to(STATISTIC_TOPIC_NAME)

    goalStream.map[String, AnyRef]((k, v) => {
      implicit val formats = DefaultFormats
      val event = parse(v.toString).extract[Event]

      try {
        val con: Connection = DriverManager.getConnection(connectionUrl)
        val stmt: Statement = con.createStatement()
        val sql =
          s"""
             DECLARE @res BIT = 0
             EXEC @res = [dbo].[EventUpdateValues]
              @MatchId = """ + event.MatchId + """
             ,@ScoreHomeTeam = """ + event.ScoreHomeTeam + """
              ,@ScoreAwayTeam = """ + event.ScoreAwayTeam + """
             select @res
       """.stripMargin

        stmt.executeQuery(sql)
        println("Updated => " + v)
      }
      // Handle any errors that may have occurred.
      catch  {
        case e: SQLException => e.printStackTrace();
      }
      KeyValue.pair(null, null)
    })

    startedStream.map[String, AnyRef]((k, v) => {
      implicit val formats = DefaultFormats
      val event = parse(v.toString).extract[Event]


      try {
        val con: Connection = DriverManager.getConnection(connectionUrl)
        val stmt: Statement = con.createStatement()
        val sql = s"UPDATE [dbo].[Matches] SET [IsStarted] = 1 WHERE [Id] = " + event.MatchId

        stmt.execute(sql)
        println("Match was started with id => " + event.MatchId)
      }
      // Handle any errors that may have occurred.
      catch  {
        case e: SQLException => e.printStackTrace();
      }
      KeyValue.pair(null, null)
    })

    val streams: KafkaStreams = new KafkaStreams(builder.build(), props)
    streams.start()

    sys.ShutdownHookThread {
      streams.close(Duration.ofSeconds(10))
    }
  }
}