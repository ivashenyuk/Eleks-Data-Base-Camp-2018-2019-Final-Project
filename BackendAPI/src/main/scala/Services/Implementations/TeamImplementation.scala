package Services.Implementations

import Entities.Mappers.TeamMapper
import Entities.Team
import Services.Traits.TeamService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.dao.EmptyResultDataAccessException
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

import scala.collection.JavaConverters._

@Service
class TeamImplementation(@Autowired
                         @Qualifier("mssqlJdbcTemplate")
                         val sqlServerTemplate: JdbcTemplate) extends TeamService {

  override def addNewTeam(team: Team): Int = {
    val sql =
      s"""
         | DECLARE @TeamId INT = -1
         | EXEC @TeamId = [dbo].[TeamAdd]
         |	@ClubId = ?
         |	,@TeamManagerId = ?
         |	,@Name = ?
         | select @TeamId
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE, team.clubId.toString, team.teamManagerId.toString, team.name)

    res.asInstanceOf[Int]

  }

  override def removeTeam(id: Int): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[TeamRemove]
         |	@TeamId = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, id.toString)

    res
  }

  override def updateTeam(team: Team): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[TeamUpdate]
         |  @TeamId = ?
         |	,@ClubId = ?
         |	,@TeamManagerId = ?
         |	,@Name = ?
         | SELECT @res
       """.stripMargin

      val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, team.id.toString,
        team.clubId.toString,
        team.teamManagerId.toString,
        team.name)

      res
  }

  override def getTeamById(id: Int): Team = {
    val sql =
      s"""
         | EXEC [dbo].[TeamGet] @TeamId = ?
       """.stripMargin

    try {
      val res: Team = sqlServerTemplate.queryForObject(sql, new TeamMapper(), id.toString)

      res
    } catch {
      case _: EmptyResultDataAccessException => null
    }
  }

  override def getTeams(): Iterable[Team] = {
    val sql =
      s"""
         | EXEC [dbo].[TeamGet]
       """.stripMargin

    sqlServerTemplate.query(sql, new TeamMapper()).asScala.toList

  }
}
