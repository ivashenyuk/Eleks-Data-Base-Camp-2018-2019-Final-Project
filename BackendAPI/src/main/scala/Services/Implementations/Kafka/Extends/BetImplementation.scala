package Services.Implementations.Kafka.Extends

import java.sql.Timestamp
import java.time.LocalDate
import java.util.Random

import Configurations.KafkaConfigurations.Extends.BetProducerConfigProps
import Entities.{BetRequest, BetResponse}
import Entities.Mappers.{BetMapper, MatchMapper}
import Helpers.MatchStartedException
import Services.Implementations.Kafka.AbstractClasses.ProducerImplementation
import Services.Traits.BetService
import Services.Traits.Kafka.BetProducerService
import com.sksamuel.avro4s.RecordFormat
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

import scala.collection.JavaConverters._

@Service
class BetImplementation(@Autowired
                        @Qualifier("mssqlJdbcTemplate")
                        val sqlServerTemplate: JdbcTemplate,
                        @Autowired
                        @Qualifier("BetProducerConfigProps")
                        val betProducerConfigProps: BetProducerConfigProps)
  extends ProducerImplementation(betProducerConfigProps)
    with BetProducerService
    with BetService {

  // <editor-fold defaultState="collapsed" desc="BetProducerService">

  override val valueFormatter = RecordFormat[BetRequest]

  override def sendBetToKafka(bet: BetRequest): Unit = {
    val sql =
      s"""
         |EXEC MatchGet @MatchId = ?
      """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, new MatchMapper(), bet.MatchId.toString)
    if(res.IsStarted)
      throw new MatchStartedException()

    bet.ChanceToWin = getRandomFloat()
    bet.CoefficientAwayWin = getRandomFloat() + Math.round(Math.random()) + 1
    bet.CoefficientHomeWin = getRandomFloat() + Math.round(Math.random()) + 1
    bet.CoefficientAwayWinOrDraw = getRandomFloat() + Math.round(Math.random()) + 1
    bet.CoefficientHomeWinOrDraw = getRandomFloat() + Math.round(Math.random()) + 1
    bet.CoefficientHomeWinOrAwayWin = getRandomFloat() + Math.round(Math.random()) + 1
    bet.CoefficientHandicap = getRandomFloat() + Math.round(Math.random()) + 1
    bet.CoefficientDraw = getRandomFloat() + Math.round(Math.random()) + 1
    bet.CommissionOfSite = getRandomFloat()
    bet.HandicapValue = getRandomFloat() + new Random().nextInt(30)

    val value = getRandomFloat()
    bet.Tax = if (value > 0.4) 0.4f else value
    bet.MaxAmountPutMoney = 150000
//    bet.Date = new Timestamp(System.currentTimeMillis)
    val start = LocalDate.of(2017, 1, 1)
     val end   = LocalDate.of(2019, 2, 27)
    bet.Date = Timestamp.valueOf(randomDate(start, end).atStartOfDay)
    bet.Prize = bet.PutMoney / BigDecimal.valueOf((1 - bet.ChanceToWin).toDouble)
    bet.Over = getRandomFloat()
    bet.Under = getRandomFloat()
    bet.Total = getRandomFloat()
    bet.ResultIsWin = false

    sendInformation(bet)
  }

  override def sendInformation(information: AnyRef): Unit = {
    val bet: BetRequest = information.asInstanceOf[BetRequest]
    genericRecord = valueFormatter.to(bet)
    sendDataToTopic(bet.toString, genericRecord)
  }

  private def getRandomFloat(): Float = {
    val min = 0.01f
    val max = 0.99f
    val range = max - min
    val random = Math.random.toFloat
    val adjustment = range * random
    min + adjustment
  }

  // </editor-fold>

  // <editor-fold defaultState="collapsed" desc="BetService">

  override def getBetById(id: Int): BetResponse = {
    val sql =
      s"""
         |EXEC BetGet @BetId = ?
      """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, new BetMapper(), id.toString)

    res
  }

  override def getBets(): Iterable[BetResponse] = {
    val sql =
      s"""
         |EXEC BetGet
      """.stripMargin

    val res: List[BetResponse] = sqlServerTemplate.query(sql, new BetMapper()).asScala.toList

    res
  }

  def randomDate(from: LocalDate, to: LocalDate): LocalDate = {
    val diff = java.time.temporal.ChronoUnit.DAYS.between(from, to)
    val random = new Random(System.nanoTime) // You may want a different seed
    from.plusDays(random.nextInt(diff.toInt))
  }
  // </editor-fold>
}
