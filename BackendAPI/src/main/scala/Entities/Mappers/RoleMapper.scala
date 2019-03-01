package Entities.Mappers

import java.sql.ResultSet

import Entities.Role
import org.springframework.jdbc.core.RowMapper

class RoleMapper extends RowMapper[Role]{
  override def mapRow(rs: ResultSet, rowNum: Int): Role = {
    Role(
      rs.getInt("Id"),
      rs.getNString("Role"),
      rs.getNString("Description")
    )
  }
}
