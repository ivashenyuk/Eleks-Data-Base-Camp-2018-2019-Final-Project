package Services.Implementations

import Entities.Club
import Entities.Mappers.ClubMapper
import Services.Traits.ClubService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.dao.EmptyResultDataAccessException
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service
import scala.collection.JavaConverters._

@Service
class ClubImplementation(@Autowired
                         @Qualifier("mssqlJdbcTemplate")
                         val sqlServerTemplate: JdbcTemplate)  extends ClubService{
  override def addNewClub(club: Club): Int = {
    val sql =
      s"""
         | DECLARE @ClubId INT = -1
         |
         | EXEC @ClubId = [dbo].[ClubAdd]
         |	@Name = ?
         |	,@ClubManagerId = ?
         |
         | select @ClubId
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE, club.name, club.clubManagerId.toString)

    res.asInstanceOf[Int]

  }

  override def removeClub(id: Int): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[ClubRemove]
         |	@ClubId = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, id.toString)

    res
  }

  override def updateClub(club: Club): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         |
         | EXEC @res = [dbo].[ClubUpdate]
         |  @ClubId = ?
         |	,@Name = ?
         |	,@ClubManagerId = ?
         |
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, club.id.toString,
      club.name,
      club.clubManagerId.toString)

    res
  }

  override def getClubById(id: Int): Club = {
    val sql =
      s"""
         | EXEC [dbo].[ClubGet] @ClubId = ?
       """.stripMargin

    try {
      val res: Club = sqlServerTemplate.queryForObject(sql, new ClubMapper(), id.toString)

      res
    } catch {
      case _: EmptyResultDataAccessException => null
    }
  }

  override def getClubs(): Iterable[Club] = {
    val sql =
      s"""
         | EXEC [dbo].[ClubGet]
       """.stripMargin

    sqlServerTemplate.query(sql, new ClubMapper()).asScala.toList

  }
}
