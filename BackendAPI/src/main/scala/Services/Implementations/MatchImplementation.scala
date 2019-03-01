package Services.Implementations

import Entities.Mappers.MatchMapper
import Entities.Match
import Services.Traits.MatchService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

import scala.collection.JavaConverters._

@Service
class MatchImplementation(@Autowired
                          @Qualifier("mssqlJdbcTemplate")
                          val sqlServerTemplate: JdbcTemplate) extends MatchService {
  
  override def addNewMatch(matchEntity: Match): Int = {
    val sql =
      s"""
         | DECLARE @MatchId INT = -1
         | EXEC @MatchId = [dbo].[MatchAdd]
         |	@HomeTeamId = ?
         |  ,@AwayTeamId = ?
         |  ,@ManagerId = ?
         |  ,@LocationId = ?
         |  ,@SportId = ?
         |  ,@TournamentId = ?
         |  ,@Date = ?
         | select @MatchId
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE,
      matchEntity.homeTeamId.toString,
      matchEntity.awayTeamId.toString,
      matchEntity.managerId.toString,
      matchEntity.locationId.toString,
      matchEntity.sportId.toString,
      matchEntity.tournamentId.toString,
      matchEntity.date)

    res.asInstanceOf[Int]
  }

  override def removeMatch(id: Int): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[MatchRemove]
         |	@MatchId = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, id.toString)

    res
  }

  override def updateMatch(matchEntity: Match): Boolean = {
    val sql =
      s"""
         | DECLARE @res BIT = 0
         | EXEC @res = [dbo].[MatchUpdate]
         |  @MatchId = ?
         |	,@HomeTeamId = ?
         |  ,@AwayTeamId = ?
         |  ,@ManagerId = ?
         |  ,@LocationId = ?
         |  ,@SportId = ?
         |  ,@TournamentId = ?
         |  ,@Date = ?
         | select @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE,
      matchEntity.id.toString,
      matchEntity.homeTeamId.toString,
      matchEntity.awayTeamId.toString,
      matchEntity.managerId.toString,
      matchEntity.locationId.toString,
      matchEntity.sportId.toString,
      matchEntity.tournamentId.toString,
      matchEntity.date)

    res
  }

  override def getMatchById(id: Int): Match = {
    val sql =
      s"""
         | EXEC [dbo].[MatchGet] @MatchId = ?
       """.stripMargin

    val res: Match = sqlServerTemplate.queryForObject(sql, new MatchMapper(), id.toString)

    res
  }

  override def getMatches(): Iterable[Match] = {
    val sql =
      s"""
         | EXEC [dbo].[MatchGet]
       """.stripMargin

    sqlServerTemplate.query(sql, new MatchMapper()).asScala.toList
  }
}
