package Entities.Mappers

import java.sql.ResultSet

import Entities.BetResponse
import org.springframework.jdbc.core.RowMapper

class BetMapper extends RowMapper[BetResponse] {
  override def mapRow(rs: ResultSet, rowNum: Int): BetResponse = {
    new BetResponse(
      rs.getInt("Id"),
      rs.getInt("MatchId"),
      rs.getInt("UserId"),
      rs.getInt("ScoreHomeTeam"),
      rs.getInt("ScoreAwayTeam"),
      rs.getFloat("ChanceToWin"),
      rs.getBigDecimal("PutMoney"),
      rs.getFloat("Tax"),
      rs.getFloat("CommissionOfSite"),
      rs.getBigDecimal("Prize"),
      rs.getTimestamp("Date"),
      rs.getFloat("CoefficientHomeWin"),
      rs.getFloat("CoefficientAwayWin"),
      rs.getFloat("CoefficientDraw"),
      rs.getFloat("CoefficientHomeWinOrAwayWin"),
      rs.getFloat("CoefficientAwayWinOrDraw"),
      rs.getFloat("CoefficientHomeWinOrDraw"),
      rs.getFloat("HandicapValue"),
      rs.getFloat("CoefficientHandicap"),
      rs.getFloat("Over"),
      rs.getFloat("Under"),
      rs.getFloat("Total"),
      rs.getBigDecimal("MaxAmountPutMoney"),
      rs.getBoolean("Result")
    )
  }
}
