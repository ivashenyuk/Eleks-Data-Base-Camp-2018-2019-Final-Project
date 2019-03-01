package Entities

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import org.springframework.lang.Nullable

import scala.beans.BeanProperty

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class Team(
                 @BeanProperty
                 id: Int,

                 @BeanProperty
                 @Nullable
                 clubId: Int,

                 @BeanProperty
                 @Nullable
                 teamManagerId: Int,

                 @BeanProperty
                 name: String) {}
