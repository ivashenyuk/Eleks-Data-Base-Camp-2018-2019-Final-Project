package Controllers.KafkaControllers

import Configurations.KafkaConfigurations.Extends.EventProducerConfigProps
import Entities.{EventRequest, EventResponse}
import Services.Traits.EventService
import Services.Traits.Kafka.EventProducerService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._

import scala.collection.JavaConverters._

@RestController
@RequestMapping(path = Array("/api/kafka/event"))
class EventController(
                      @Autowired
                      val eventProducerService: EventProducerService,
                      @Autowired
                      val eventService: EventService,
                      @Autowired
                      @Qualifier("EventProducerConfigProps")
                      val eventProducerConfigProps: EventProducerConfigProps
                    ) {

  // <editor-fold defaultState="collapsed" desc="Kafka producer">

  // add new line information[ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def addNewEvent(@RequestBody
                event: EventRequest): Unit = {
    eventProducerService.sendEventToKafka(event)
  }

  // </editor-fold>

  // <editor-fold defaultState="collapsed" desc="default service for GETs">


  // get bankCard by id [ Method = GET ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getEventById(@PathVariable("id")
                 id: Int): EventResponse = {
    eventService.getEventById(id)
  }

  // get all bankCards [ Method = GET ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getAllEvents: java.util.List[EventResponse] = {
    eventService.getEvents().toList.asJava
  }

  // </editor-fold>
}

