package Services.Implementations

import Entities.Mappers.LocationMapper
import Entities.Location
import Services.Traits.LocationService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.dao.EmptyResultDataAccessException
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

import scala.collection.JavaConverters._

@Service
class LocationImplementation(@Autowired
                             @Qualifier("mssqlJdbcTemplate")
                             val sqlServerTemplate: JdbcTemplate) extends LocationService {

  override def addNewLocation(location: Location): Int = {
    val sql =
      s"""
         | DECLARE @LocationId INT = -1
         | EXEC @LocationId = [dbo].[LocationAdd]
         |  @City = ?
         |	,@State = ?
         |  ,@Country = ?
         | select @LocationId
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE,
      location.city,
      location.state,
      location.country)

    res.asInstanceOf[Int]

  }

  override def removeLocation(id: Int): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[LocationRemove]
         |	@LocationId = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, id.toString)

    res
  }

  override def updateLocation(location: Location): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[LocationUpdate]
         |  @LocationId = ?
         |	,@City = ?
         |	,@State = ?
         |	,@Country = ?
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, location.id.toString,
      location.city,
      location.state,
      location.country)

    res
  }

  override def getLocationById(id: Int): Location = {
    val sql =
      s"""
         | EXEC [dbo].[LocationGet] @LocationId = ?
       """.stripMargin

    try {
      val res: Location = sqlServerTemplate.queryForObject(sql, new LocationMapper(), id.toString)

      res
    } catch {
      case _: EmptyResultDataAccessException => null
    }
  }

  override def getLocations(): Iterable[Location] = {
    val sql =
      s"""
         | EXEC [dbo].[LocationGet]
       """.stripMargin

    sqlServerTemplate.query(sql, new LocationMapper()).asScala.toList

  }
}
