package Entities.Mappers

import java.sql.ResultSet

import Entities.Sport
import org.springframework.jdbc.core.RowMapper

class SportMapper extends RowMapper[Sport] {
  override def mapRow(rs: ResultSet, rowNum: Int): Sport = {
    Sport(
      rs.getInt("Id"),
      rs.getNString("Name"),
      rs.getNString("Description")
    )
  }
}
