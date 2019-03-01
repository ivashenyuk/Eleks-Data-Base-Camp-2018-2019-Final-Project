package Entities.Mappers

import java.sql.ResultSet

import Entities.Club
import org.springframework.jdbc.core.RowMapper

class ClubMapper extends RowMapper[Club] {
  override def mapRow(rs: ResultSet, rowNum: Int): Club = {
    Club(rs.getInt("Id"),
      rs.getNString("Name"),
      rs.getInt("ClubManagerId")
    )
  }
}
