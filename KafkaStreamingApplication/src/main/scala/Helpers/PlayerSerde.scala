//package Helpers
//
//import java.util
//
//import Entities.Player
//import org.apache.kafka.common.serialization.{Deserializer, Serde, Serializer}
//
//@Deprecated
//class PlayerSerde  extends  Serde[Player]{
//  override def configure(configs: util.Map[String, _], isKey: Boolean): Unit = {}
//
//  override def close(): Unit = {}
//
//  override def serializer(): Serializer[Player] = new PlayerSerializer()
//
//  override def deserializer(): Deserializer[Player] = new PlayerDeserializer()
//}
