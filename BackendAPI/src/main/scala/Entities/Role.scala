package Entities

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.JsonSerialize

import scala.beans.BeanProperty

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class Role(
                 @BeanProperty
                 id: Int,

                 @BeanProperty
                 role: String,

                 @BeanProperty
                 description: String
               ) {}
