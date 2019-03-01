package Controllers.KafkaControllers

import Configurations.KafkaConfigurations.Extends.BetProducerConfigProps
import Entities.{BetRequest, BetResponse}
import Helpers.MatchStartedException
import Services.Traits.BetService
import Services.Traits.Kafka.BetProducerService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._

import scala.collection.JavaConverters._

@RestController
@RequestMapping(path = Array("/api/kafka/bet"))
class BetsController(
                      @Autowired
                      val betProducerService: BetProducerService,
                      @Autowired
                      val betService: BetService,
                      @Autowired
                      @Qualifier("BetProducerConfigProps")
                      val betProducerConfigProps: BetProducerConfigProps
                    ) {

  // <editor-fold defaultstate="collapsed" desc="Kafka producer">

  // add new line information[ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def addNewBet(@RequestBody
                bet: BetRequest): String = {
    try {
      betProducerService.sendBetToKafka(bet)
      "Ok!"
    }
    catch {
      case e: MatchStartedException => e.message
      case e: Exception => "Internal server error. Try again."
    }
  }

  // </editor-fold>

  // <editor-fold defaultstate="collapsed" desc="default service for GETs">


  // get bankCard by id [ Method = GET ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getBetById(@PathVariable("id")
                      id: Int): BetResponse = {
    betService.getBetById(id)
  }

  // get all bankCards [ Method = GET ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getAllBets: java.util.List[BetResponse] = {
    betService.getBets().toList.asJava
  }

  // </editor-fold>
}
