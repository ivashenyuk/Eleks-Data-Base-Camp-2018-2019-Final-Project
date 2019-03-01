package Entities.Mappers

import java.sql.ResultSet

import Entities.EventResponse
import org.springframework.jdbc.core.RowMapper

class EventMapper extends RowMapper[EventResponse] {
  override def mapRow(rs: ResultSet, rowNum: Int): EventResponse = {
    EventResponse(
      rs.getInt("Id"),
      rs.getInt("MatchId"),
      rs.getString("DescriptionEvent"),
      rs.getInt("ScoreHomeTeam"),
      rs.getInt("ScoreAwayTeam"),
      rs.getString("TimeEvent")
    )
  }
}
