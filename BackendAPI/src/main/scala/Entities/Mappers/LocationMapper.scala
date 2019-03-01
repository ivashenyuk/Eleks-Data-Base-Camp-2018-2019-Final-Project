package Entities.Mappers

import java.sql.ResultSet

import Entities.Location
import org.springframework.jdbc.core.RowMapper

class LocationMapper extends RowMapper[Location]{
  override def mapRow(rs: ResultSet, rowNum: Int): Location = {
    Location(
      rs.getInt("Id"),
      rs.getNString("City"),
      rs.getNString("State"),
      rs.getNString("Country")
    )
  }
}
