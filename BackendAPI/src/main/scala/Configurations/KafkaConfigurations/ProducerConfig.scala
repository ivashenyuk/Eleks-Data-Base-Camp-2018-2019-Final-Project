package Configurations.KafkaConfigurations

import Configurations.KafkaConfigurations.Extends.{BetProducerConfigProps, EventProducerConfigProps}
import org.springframework.boot.autoconfigure.EnableAutoConfiguration
import org.springframework.context.annotation.{Bean, Configuration}

@EnableAutoConfiguration
@Configuration
class ProducerConfig {

  @Bean(name = Array("BetProducerConfigProps"))
  def bindingBetProducer: BetProducerConfigProps = {
    new BetProducerConfigProps()
  }

  @Bean(name = Array("EventProducerConfigProps"))
  def bindingEventProducer: EventProducerConfigProps = {
    new EventProducerConfigProps()
  }
}


