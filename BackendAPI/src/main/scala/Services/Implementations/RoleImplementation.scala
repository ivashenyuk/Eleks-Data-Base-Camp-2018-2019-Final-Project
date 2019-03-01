package Services.Implementations

import Entities.Mappers.RoleMapper
import Entities.Role
import Services.Traits.RoleService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.dao.EmptyResultDataAccessException
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

import scala.collection.JavaConverters._

@Service
class RoleImplementation(@Autowired
                         @Qualifier("mssqlJdbcTemplate")
                         val sqlServerTemplate: JdbcTemplate) extends RoleService {

  override def addNewRole(role: Role): Int = {
    val sql =
      s"""
         | DECLARE @RoleId INT = -1
         | EXEC @RoleId = [dbo].[RoleAdd]
         |	@Role = ?
         |	,@Description = ?
         |
         | select @RoleId
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE, role.role, role.description)

    res.asInstanceOf[Int]

  }

  override def removeRole(id: Int): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[RoleRemove]
         |	@RoleId = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, id.toString)

    res
  }

  override def updateRole(role: Role): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[RoleUpdate]
         |  @RoleId = ?
         |  ,@Role = ?
         |  ,@Description = ?
         |
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, role.id.toString,
      role.role,
      role.description)

    res
  }

  override def getRoleById(id: Int): Role = {
    val sql =
      s"""
         | EXEC [dbo].[RoleGet] @RoleId = ?
       """.stripMargin

    try {
      val res: Role = sqlServerTemplate.queryForObject(sql, new RoleMapper(), id.toString)

      res
    } catch {
      case _: EmptyResultDataAccessException => null
    }
  }

  override def getRoles(): Iterable[Role] = {
    val sql =
      s"""
         | EXEC [dbo].[RoleGet]
       """.stripMargin

    sqlServerTemplate.query(sql, new RoleMapper()).asScala.toList

  }
}
