package Entities

import com.fasterxml.jackson.annotation.JsonSubTypes.Type
import com.fasterxml.jackson.annotation.{JsonSubTypes, JsonTypeInfo}

import scala.beans.BeanProperty

case class Information(@BeanProperty
                       id: Int)
