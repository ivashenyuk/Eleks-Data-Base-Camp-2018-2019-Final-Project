package Entities

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.JsonSerialize

import scala.beans.BeanProperty

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class Location(
                     @BeanProperty
                     id: Int,

                     @BeanProperty
                     city: String,

                     @BeanProperty
                     state: String,

                     @BeanProperty
                     country: String
                   ) {}
