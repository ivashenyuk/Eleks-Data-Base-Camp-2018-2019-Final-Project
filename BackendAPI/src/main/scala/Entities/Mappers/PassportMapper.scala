package Entities.Mappers

import java.sql.ResultSet

import Entities.Passport._
import org.springframework.jdbc.core.RowMapper

class PassportMapper extends RowMapper[PassportResponse]{
  override def mapRow(rs: ResultSet, rowNum: Int): PassportResponse = {
    PassportResponse(
      rs.getInt("Id"),
      rs.getInt("PassportCode"),
      rs.getNString("Series"),
      rs.getDate("BirthDay"),
      rs.getNString("FirstName"),
      rs.getNString("LastName"),
      rs.getInt("PhotoPage1Id"),
      rs.getInt("PhotoPage2Id"),
      rs.getInt("PhotoRegistrationId"),
      rs.getInt("PhotoIDOwnerId"),
      rs.getInt("PhotoOwnerWithPassportId")
    )
  }
}
