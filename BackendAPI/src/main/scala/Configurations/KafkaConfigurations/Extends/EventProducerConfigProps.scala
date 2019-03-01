package Configurations.KafkaConfigurations.Extends

import Configurations.KafkaConfigurations.AbstractClasses.ProducerConfigProps
import org.springframework.beans.factory.annotation.Value

class EventProducerConfigProps extends ProducerConfigProps  {

  @Value("${confluent.topics.events}")
  override val topicName: String = ""
}
