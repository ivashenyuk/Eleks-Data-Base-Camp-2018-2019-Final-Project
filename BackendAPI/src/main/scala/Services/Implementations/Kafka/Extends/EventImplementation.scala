package Services.Implementations.Kafka.Extends

import Configurations.KafkaConfigurations.Extends.EventProducerConfigProps
import Entities.{EventRequest, EventResponse}
import Entities.Mappers.EventMapper
import Services.Implementations.Kafka.AbstractClasses.ProducerImplementation
import Services.Traits.EventService
import Services.Traits.Kafka.EventProducerService
import com.sksamuel.avro4s.RecordFormat
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

import scala.collection.JavaConverters._

@Service
class EventImplementation(@Autowired
                          @Qualifier("mssqlJdbcTemplate")
                          val sqlServerTemplate: JdbcTemplate,

                          @Autowired
                          @Qualifier("EventProducerConfigProps")
                          val eventProducerConfigProps: EventProducerConfigProps)
  extends ProducerImplementation(eventProducerConfigProps)
    with EventProducerService
    with EventService {

  // <editor-fold defaultState="collapsed" desc="BetProducerService">

  override val valueFormatter = RecordFormat[EventRequest]

  override def sendEventToKafka(event: EventRequest): Unit = {
    sendInformation(event)
  }

  override def sendInformation(information: AnyRef): Unit = {
    val event: EventRequest = information.asInstanceOf[EventRequest]

    genericRecord = valueFormatter.to(event)
    sendDataToTopic(event.DescriptionEvent, genericRecord)
  }

  // </editor-fold>

  // <editor-fold defaultState="collapsed" desc="BetService">

  override def getEventById(id: Int): EventResponse = {
    val sql =
      s"""
         |EXEC EventGet @EventId = ?
      """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, new EventMapper(), id.toString)

    res
  }

  override def getEvents(): Iterable[EventResponse] = {
    val sql =
      s"""
         |EXEC EventGet
      """.stripMargin

    val res: List[EventResponse] = sqlServerTemplate.query(sql, new EventMapper()).asScala.toList

    res
  }

  // </editor-fold>
}
