package Entities

import java.sql.Timestamp

import Controllers.KafkaControllers.CustomDeserializers.CustomerDateAndTimeDeserialize
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.{JsonDeserialize, JsonSerialize}

import scala.beans.BeanProperty

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class Match(
                  @BeanProperty
                  id: Int,

                  @BeanProperty
                  homeTeamId: Int,

                  @BeanProperty
                  awayTeamId: Int,

                  @BeanProperty
                  managerId: Int,

                  @BeanProperty
                  locationId: Int,

                  @BeanProperty
                  sportId: Int,

                  @BeanProperty
                  tournamentId: Int,

                  @BeanProperty
                  scoreHomeTeam: Int,

                  @BeanProperty
                  scoreAwayTeam: Int,

                  @BeanProperty
                  IsStarted: Boolean,

                  @BeanProperty
                  date: String
                ) {
}
