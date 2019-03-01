//package Helpers
//
//import java.io.ByteArrayOutputStream
//import java.nio.ByteBuffer
//import java.util
//
//import Entities.Player
//import com.fasterxml.jackson.databind.ObjectMapper
//import org.apache.avro.io.{Encoder, EncoderFactory}
//import org.apache.avro.specific.SpecificDatumWriter
//import org.apache.kafka.common.errors.SerializationException
//import org.apache.kafka.common.serialization.Serializer
//
//@Deprecated
//class PlayerSerializer  extends Serializer[Player]{
//  private val objectMapper = new ObjectMapper()
//
//  private var tClass: Class[Player] = _
//  override def configure(configs: util.Map[String, _], isKey: Boolean): Unit = {
//    tClass = configs.get("JsonPOJOClass").asInstanceOf[Class[Player]]
//  }
//
//  override def serialize(topic: String, data: Player): Array[Byte] = {
////    if (data == null)
////      return null
////
////    try {
////      return objectMapper.writeValueAsBytes(data);
////    } catch {
////      case e: Exception => throw new SerializationException("Error serializing JSON message", e);
////    }
//    val out: ByteArrayOutputStream = new ByteArrayOutputStream()
//    val encoder: Encoder = EncoderFactory.get().directBinaryEncoder(out, null)
//
//    // specific writer
//    val writer: SpecificDatumWriter[Player]  = new SpecificDatumWriter[Player](Player.SCHEMA$)
//    writer.write(data, encoder)
//    encoder.flush()
//    val serialized: ByteBuffer = ByteBuffer.allocate(out.toByteArray.length)
//    serialized.put(out.toByteArray)
//    serialized.array()
//  }
//
//  override def close(): Unit = {}
//}
