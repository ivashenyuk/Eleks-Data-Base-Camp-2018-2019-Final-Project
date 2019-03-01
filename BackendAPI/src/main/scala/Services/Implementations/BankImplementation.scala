package Services.Implementations

import Entities.Bank
import Entities.Mappers.{BankMapper, ClubMapper}
import Services.Traits.BankService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.dao.EmptyResultDataAccessException
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

import scala.collection.JavaConverters._

@Service
class BankImplementation(@Autowired
                         @Qualifier("mssqlJdbcTemplate")
                         val sqlServerTemplate: JdbcTemplate) extends BankService {
  override def addNewBank(bank: Bank): Int = {
    val sql =
      s"""
         | DECLARE @BankId INT = -1
         |
         | EXEC @BankId = [dbo].[BankAdd]
         |	@Name = ?
         |  ,@MinMoneyToWithdraw = ?
         |	,@Commission = ?
         |  ,@TimeOfProcessing = ?
         |  ,@Description = ?
         |
         | select @BankId
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE,
      bank.name,
      bank.minMoneyToWithdraw.toString,
      bank.commission.toString,
      bank.timeOfProcessing.toString,
      bank.description)


    res.asInstanceOf[Int]

  }

  override def removeBank(id: Int): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[BankRemove]
         |	@bankId = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, id.toString)

    res
  }

  override def updateBank(bank: Bank): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         |
         | EXEC @res = [dbo].[BankUpdate]
         |  @BankId = ?
         |	,@Name = ?
         |  ,@MinMoneyToWithdraw = ?
         |	,@Commission = ?
         |  ,@TimeOfProcessing = ?
         |  ,@Description = ?
         |
         | SELECT @res
       """.stripMargin


    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, bank.id.toString,
      bank.getName,
      if (bank.getMinMoneyToWithdraw == null) 0.0.toString else bank.getMinMoneyToWithdraw.toString,
      bank.getCommission.toString,
      bank.getTimeOfProcessing.toString,
      bank.getDescription)

    res
  }

  override def getBankById(id: Int): Bank = {
    val sql =
      s"""
         | EXEC [dbo].[BankGet] @BankId = ?
       """.stripMargin

    try {
      val res: Bank = sqlServerTemplate.queryForObject(sql, new BankMapper(), id.toString)

      res
    } catch {
      case _: EmptyResultDataAccessException => null
    }
  }

  override def getBanks(): Iterable[Bank] = {
    val sql =
      s"""
         | EXEC [dbo].[BankGet]
       """.stripMargin

    sqlServerTemplate.query(sql, new BankMapper()).asScala.toList

  }
}

