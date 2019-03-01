package Entities.Mappers

import java.sql.ResultSet

import Entities.Bank
import org.springframework.jdbc.core.RowMapper

class BankMapper extends RowMapper[Bank] {
  override def mapRow(rs: ResultSet, rowNum: Int): Bank = {
    Bank(
      rs.getInt("Id"),
      rs.getNString("Name"),
      rs.getBigDecimal("MinMoneyToWithdraw"),
      rs.getFloat("Commission"),
      rs.getLong("TimeOfProcessing"),
      rs.getNString("Description")
    )
  }
}
