package Entities

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import org.springframework.lang.Nullable

import scala.beans.BeanProperty

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class Club(
                 @BeanProperty
                 id: Int,

                 @BeanProperty
                 name: String,

                 @BeanProperty
                 @Nullable
                 clubManagerId: Int
               ) {

}
