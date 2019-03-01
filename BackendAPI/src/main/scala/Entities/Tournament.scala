package Entities

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.JsonSerialize

import scala.beans.BeanProperty

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class Tournament(
                       @BeanProperty
                       id: Int,

                       @BeanProperty
                       name: String,

                       @BeanProperty
                       organizationName: String,

                       @BeanProperty
                       description: String) {}
