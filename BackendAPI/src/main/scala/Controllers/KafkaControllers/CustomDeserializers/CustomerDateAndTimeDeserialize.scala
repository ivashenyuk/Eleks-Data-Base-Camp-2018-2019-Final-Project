package Controllers.KafkaControllers.CustomDeserializers

import java.io.IOException
import java.sql.Timestamp
import java.text.SimpleDateFormat

import com.fasterxml.jackson.core.{JsonParser, JsonProcessingException}
import com.fasterxml.jackson.databind.{DeserializationContext, JsonDeserializer}

class CustomerDateAndTimeDeserialize extends JsonDeserializer[Timestamp] {


  private val dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")

  @throws[IOException]
  @throws[JsonProcessingException]
  def deserialize(paramJsonParser: JsonParser, paramDeserializationContext: DeserializationContext): Timestamp = {
    val str = paramJsonParser.getText.trim
    println(str)
    try
      return new Timestamp(dateFormat.parse(str).getTime)
    catch {
      case _: Exception =>
      // Handle exception here
    }
    new Timestamp(paramDeserializationContext.parseDate(str).getTime)
  }
}
