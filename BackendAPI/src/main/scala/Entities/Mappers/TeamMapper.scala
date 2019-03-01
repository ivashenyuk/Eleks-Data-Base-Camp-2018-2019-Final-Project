package Entities.Mappers

import java.sql.ResultSet

import Entities.Team
import org.springframework.jdbc.core.RowMapper

class TeamMapper extends RowMapper[Team] {
  override def mapRow(rs: ResultSet, rowNum: Int): Team = {
    Team(
      rs.getInt("Id"),
      rs.getInt("ClubId"),
      rs.getInt("TeamManagerId"),
      rs.getNString("Name")
    )
  }
}
