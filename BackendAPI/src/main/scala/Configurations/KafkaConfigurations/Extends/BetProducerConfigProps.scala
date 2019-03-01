package Configurations.KafkaConfigurations.Extends

import Configurations.KafkaConfigurations.AbstractClasses.ProducerConfigProps
import org.springframework.beans.factory.annotation.Value

class BetProducerConfigProps extends ProducerConfigProps {

  @Value("${confluent.topics.bets}")
  override val topicName: String = ""
}