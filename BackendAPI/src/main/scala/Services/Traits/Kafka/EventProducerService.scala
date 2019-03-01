package Services.Traits.Kafka

import Entities.EventRequest

trait EventProducerService {
  def sendEventToKafka(event: EventRequest): Unit
}
