package Services.Implementations.Kafka.AbstractClasses

import Configurations.KafkaConfigurations.AbstractClasses.ProducerConfigProps
import Services.Traits.Kafka.ProducerService
import org.apache.avro.generic.GenericRecord
import org.apache.kafka.clients.producer.{KafkaProducer, ProducerRecord}

abstract class ProducerImplementation(
                                       val producerConfigProps: ProducerConfigProps
                                     ) extends ProducerService {


  protected val valueFormatter: Any
  protected val producer: KafkaProducer[String, AnyRef] = producerConfigProps.getKafkaProducer
  protected val topicName = producerConfigProps.topicName
  protected var commandRecord: ProducerRecord[String, AnyRef] = _
  protected var genericRecord: GenericRecord = _

  protected def sendDataToTopic(key: String, value: AnyRef): Unit = {
    try {
      commandRecord = new ProducerRecord[String, AnyRef](topicName, key, value)
      producer.send(commandRecord)
    } catch {
      case e: Exception => println(e.getMessage)
    }
  }
}