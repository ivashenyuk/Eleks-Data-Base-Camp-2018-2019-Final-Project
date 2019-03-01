package Entities.Mappers

import java.sql.ResultSet

import Entities.BankCard
import org.springframework.jdbc.core.RowMapper

class BankCardMapper extends RowMapper[BankCard] {
  override def mapRow(rs: ResultSet, rowNum: Int): BankCard = {
    BankCard(
      rs.getInt("Id"),
      0,
      rs.getInt("BankId"),
      rs.getString("CardNumber"),
      rs.getDate("ExpiryDateCard"),
      rs.getShort("DigitsOnBackOfCard"),
      rs.getBoolean("IsConfirmedCard")
    )
  }
}
