package Entities.Mappers

import java.sql.ResultSet

import Entities.Tournament
import org.springframework.jdbc.core.RowMapper

class TournamentMapper extends RowMapper[Tournament] {
  override def mapRow(rs: ResultSet, rowNum: Int): Tournament = {
    Tournament(
      rs.getInt("Id"),
      rs.getNString("Name"),
      rs.getNString("OrganizationName"),
      rs.getNString("Description")
    )
  }
}
