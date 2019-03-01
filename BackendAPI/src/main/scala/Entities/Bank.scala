package Entities
import com.fasterxml.jackson.annotation.{JsonEnumDefaultValue, JsonFormat, JsonIgnoreProperties}
import com.fasterxml.jackson.databind.annotation.JsonSerialize

import scala.beans.BeanProperty

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class Bank(
                 @BeanProperty
                 id: Int,

                 @BeanProperty
                 name: String,

                 @BeanProperty
                 minMoneyToWithdraw: BigDecimal,

                 @BeanProperty
                 commission: Float,

                 @BeanProperty
                 timeOfProcessing: Long,

                 @BeanProperty
                 description: String
               ) {

}
