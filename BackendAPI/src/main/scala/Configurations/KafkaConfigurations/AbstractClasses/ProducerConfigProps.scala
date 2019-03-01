package Configurations.KafkaConfigurations.AbstractClasses

import java.util.Properties

import org.apache.kafka.clients.producer.{KafkaProducer, ProducerConfig}
import org.springframework.beans.factory.annotation.Value


abstract class ProducerConfigProps {
  //******************* Properties from application.properties *******************\\
  @Value("${confluent.bootstrap.servers}")
  var bootstrapServers: String = _

  @Value("${confluent.schema.registry.url}")
  var schemeRegistryUrl: String = _

  @Value("${confluent.topic}")
  val topicName: String = ""


  def getKafkaProducer: KafkaProducer[String, AnyRef] = {

    val properties = new Properties()
    properties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers)
    properties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, "io.confluent.kafka.serializers.KafkaAvroSerializer")
    properties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, "io.confluent.kafka.serializers.KafkaAvroSerializer")
    properties.put("schema.registry.url", schemeRegistryUrl)

    new KafkaProducer[String, AnyRef](properties)
  }
}
