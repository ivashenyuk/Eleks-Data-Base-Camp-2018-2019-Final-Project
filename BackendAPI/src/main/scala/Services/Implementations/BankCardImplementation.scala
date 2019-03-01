package Services.Implementations

import Entities.BankCard
import Entities.Mappers.BankCardMapper
import Services.Traits.BankCardService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

import scala.collection.JavaConverters._

@Service
class BankCardImplementation(
                              @Autowired
                              @Qualifier("mssqlJdbcTemplate")
                              val sqlServerTemplate: JdbcTemplate
                            ) extends BankCardService {
  override def addNewBankCard(bankCard: BankCard): Int = {
    val sql =
      s"""
         |DECLARE @Id INT = -1
         |EXEC @id [dbo].[BankCardAdd]
         |  @UserId = ?
         |  ,@BankId = ?
         |  ,@CardNumber = ?
         |  ,@ExpiryDateCard = ?
         |  ,@DigitsOnBackOfCard = ?
         |  ,@IsConfirmedCard = ?
         | SELECT @id
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE,
      bankCard.userId.toString,
      bankCard.bankId.toString,
      bankCard.cardNumber,
      bankCard.expiryDateCard,
      bankCard.digitsOnBackOfCard.toString,
      bankCard.isConfirmedCard.toString)

    res.asInstanceOf[Int]
  }

  override def removeBankCard(id: Int): Boolean = {
    val sql =
      s"""
         |DECLARE @res BIT = 0
         |EXEC BankCardRemove @BankCardId = ?
         |SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE,
      id.toString)
    res
  }

  override def updateBankCard(bankCard: BankCard): Boolean = {
    val sql =
      s"""
         |DECLARE @res BIT = 0
         |EXEC @res = [dbo].[BankCardUpdate]
         |  @Id = ?
         |  ,@BankId = ?
         |  ,@CardNumber = ?
         |  ,@ExpiryDateCard = ?
         |  ,@DigitsOnBackOfCard = ?
         |  ,@IsConfirmedCard = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE,
      bankCard.id.toString,
      bankCard.bankId.toString,
      bankCard.cardNumber,
      bankCard.expiryDateCard,
      bankCard.digitsOnBackOfCard.toString,
      bankCard.isConfirmedCard.toString)

    res
  }

  override def getBankCardById(id: Int): BankCard = {
    val sql =
      s"""
         |EXEC BankCardGet @BankCardId = ?
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, new BankCardMapper(),
      id.toString)
    res
  }

  override def getBankCards(): Iterable[BankCard] = {
    val sql =
      s"""
         |EXEC BankCardGet
       """.stripMargin

    val res = sqlServerTemplate.query(sql, new BankCardMapper()).asScala.toList
    res
  }
}
