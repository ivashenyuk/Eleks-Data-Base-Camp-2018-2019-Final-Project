package Services.Implementations

import Entities.Mappers.SportMapper
import Entities.Sport
import Services.Traits.SportService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

import scala.collection.JavaConverters._

@Service
class SportImplementation(@Autowired
                          @Qualifier("mssqlJdbcTemplate")
                          val sqlServerTemplate: JdbcTemplate) extends SportService {
  override def addNewSport(sport: Sport): Int = {
    val sql =
      s"""
         | DECLARE @SportId INT = -1
         | EXEC @SportId = [dbo].[SportAdd]
         |	@Name = ?
         |	,@Description = ?
         | select @SportId
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE, sport.name, sport.description)

    res.asInstanceOf[Int]
  }

  override def removeSport(id: Int): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[SportRemove]
         |	@SportId = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, id.toString)

    res
  }

  override def updateSport(sport: Sport): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[SportUpdate]
         |  @SportId = ?
         |	,@Name = ?
         |  ,@Description = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, sport.id.toString,
      sport.name,
      sport.description)

    res
  }

  override def getSportById(id: Int): Sport = {
    val sql =
      s"""
         | EXEC [dbo].[SportGet] @SportId = ?
       """.stripMargin

      val res: Sport = sqlServerTemplate.queryForObject(sql, new SportMapper(), id.toString)

      res
  }

  override def getSports(): Iterable[Sport] = {
    val sql =
      s"""
         | EXEC [dbo].[SportGet]
       """.stripMargin

    sqlServerTemplate.query(sql, new SportMapper()).asScala.toList
  }
}
