package Entities.Mappers

import java.sql.ResultSet

import Entities.Photos._
import org.springframework.jdbc.core.RowMapper

class PhotoMapper extends RowMapper[Photo] {
  override def mapRow(rs: ResultSet, rowNum: Int): Photo = {
    Photo(
      rs.getInt("Id"),
      rs.getNString("DefaultFileName"),
      rs.getNString("Path")
    )
  }
}
