package Services.Implementations

import Entities.Mappers.TournamentMapper
import Entities.Tournament
import Services.Traits.TournamentService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

import scala.collection.JavaConverters._

@Service
class TournamentImplementation(@Autowired
                               @Qualifier("mssqlJdbcTemplate")
                               val sqlServerTemplate: JdbcTemplate) extends TournamentService {
  override def addNewTournament(tournament: Tournament): Int = {
    val sql =
      s"""
         |DECLARE @Id INT = -1
         |EXEC @Id = [dbo].[TournamentAdd]
         |  @Name = ?
         |  ,@OrganizationName = ?
         |  ,@Description = ?
         |SELECT @Id
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE,
      tournament.name,
      tournament.organizationName,
      tournament.description)

    res.asInstanceOf[Int]
  }

  override def removeTournament(id: Int): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[TournamentRemove]
         |	@TournamentId = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, id.toString)

    res
  }

  override def updateTournament(tournament: Tournament): Boolean = {
    val sql =
      s"""
         |DECLARE @res BIT = 0
         |EXEC @res = [dbo].[TournamentUpdate]
         |  @Id = ?
         |  ,@Name = ?
         |  ,@OrganizationName = ?
         |  ,@Description = ?
         |SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE,
      tournament.name,
      tournament.organizationName,
      tournament.description)

    res
  }

  override def getTournamentById(id: Int): Tournament = {
    val sql =
      s"""
         | EXEC [dbo].[TournamentGet] @TournamentId = ?
       """.stripMargin

      val res: Tournament = sqlServerTemplate.queryForObject(sql, new TournamentMapper(), id.toString)

      res
  }

  override def getTournaments(): Iterable[Tournament] = {
    val sql =
      s"""
         | EXEC [dbo].[TournamentGet]
       """.stripMargin

    sqlServerTemplate.query(sql, new TournamentMapper()).asScala.toList
  }
}
