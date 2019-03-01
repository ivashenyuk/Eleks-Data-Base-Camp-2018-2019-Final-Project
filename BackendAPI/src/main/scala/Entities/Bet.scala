package Entities

import java.sql.Timestamp

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.JsonSerialize

import scala.beans.BeanProperty

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class BetResponse(
                @BeanProperty
                id: Int,

                @BeanProperty
                matchId: Int,

                @BeanProperty
                userId: Int,

                @BeanProperty
                scoreHomeTeam: Int,

                @BeanProperty
                scoreAwayTeam: Int,

                @BeanProperty
                var chanceToWin: Float,

                @BeanProperty
                putMoney: BigDecimal,

                @BeanProperty
                var tax: Float,

                @BeanProperty
                var commissionOfSite: Float,

                @BeanProperty
                var prize: BigDecimal,

                @BeanProperty
                var date: Timestamp,

                @BeanProperty
                var coefficientHomeWin: Float,

                @BeanProperty
                var coefficientAwayWin: Float,

                @BeanProperty
                var coefficientDraw: Float,

                @BeanProperty
                var coefficientHomeWinOrAwayWin: Float,

                @BeanProperty
                var coefficientAwayWinOrDraw: Float,

                @BeanProperty
                var coefficientHomeWinOrDraw: Float,

                @BeanProperty
                var handicapValue: Float,

                @BeanProperty
                var coefficientHandicap: Float,

                @BeanProperty
                var over: Float,

                @BeanProperty
                var under: Float,

                @BeanProperty
                var total: Float,

                @BeanProperty
                var maxAmountPutMoney: BigDecimal,

                @BeanProperty
                var resultIsWin: Boolean
              ) {}

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class BetRequest(
                        @BeanProperty
                        MatchId: Int,

                        @BeanProperty
                        UserId: Int,

                        @BeanProperty
                        ScoreHomeTeam: Int,

                        @BeanProperty
                        ScoreAwayTeam: Int,

                        @BeanProperty
                        var ChanceToWin: Float,

                        @BeanProperty
                        PutMoney: BigDecimal,

                        @BeanProperty
                        var Tax: Float,

                        @BeanProperty
                        var CommissionOfSite: Float,

                        @BeanProperty
                        var Prize: BigDecimal,

                        @BeanProperty
                        var Date: Timestamp,

                        @BeanProperty
                        var CoefficientHomeWin: Float,

                        @BeanProperty
                        var CoefficientAwayWin: Float,

                        @BeanProperty
                        var CoefficientDraw: Float,

                        @BeanProperty
                        var CoefficientHomeWinOrAwayWin: Float,

                        @BeanProperty
                        var CoefficientAwayWinOrDraw: Float,

                        @BeanProperty
                        var CoefficientHomeWinOrDraw: Float,

                        @BeanProperty
                        var HandicapValue: Float,

                        @BeanProperty
                        var CoefficientHandicap: Float,

                        @BeanProperty
                        var Over: Float,

                        @BeanProperty
                        var Under: Float,

                        @BeanProperty
                        var Total: Float,

                        @BeanProperty
                        var MaxAmountPutMoney: BigDecimal,

                        @BeanProperty
                        var ResultIsWin: Boolean
                      ) {}