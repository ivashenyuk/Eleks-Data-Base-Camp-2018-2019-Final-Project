package Entities.Mappers

import java.sql.ResultSet

import Entities.Match
import org.springframework.jdbc.core.RowMapper

class MatchMapper extends RowMapper[Match] {
  override def mapRow(rs: ResultSet, rowNum: Int): Match = {
    Match(
      rs.getInt("Id"),
      rs.getInt("HomeTeamId"),
      rs.getInt("AwayTeamId"),
      rs.getInt("ManagerId"),
      rs.getInt("LocationId"),
      rs.getInt("SportId"),
      rs.getInt("TournamentId"),
      rs.getInt("ScoreHomeTeam"),
      rs.getInt("ScoreAwayTeam"),
      rs.getBoolean("IsStarted"),
      rs.getTimestamp("Date").toString
    )
  }
}
