package Entities

import java.sql.Timestamp

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import javax.validation.constraints.NotNull
import net.bytebuddy.implementation.bind.annotation.Default
import org.springframework.beans.factory.annotation.Value
import org.springframework.lang.NonNull

import scala.beans.BeanProperty

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize
case class EventResponse(@BeanProperty
                 id: Int,

                 @BeanProperty
                 matchId: Int,

                 @BeanProperty
                 descriptionEvent: String,

                 @BeanProperty
                 scoreHomeTeam: Int,

                 @BeanProperty
                 scoreAwayTeam: Int,

                 @BeanProperty
                 timeEvent: String
                ) {}
@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize
case class EventRequest(
                 @BeanProperty
                 MatchId: Int,

                 @BeanProperty
                 DescriptionEvent: String,

                 @BeanProperty
                 ScoreHomeTeam: Int,

                 @BeanProperty
                 ScoreAwayTeam: Int,

                 @BeanProperty
                 TimeEvent: String
                ) {}