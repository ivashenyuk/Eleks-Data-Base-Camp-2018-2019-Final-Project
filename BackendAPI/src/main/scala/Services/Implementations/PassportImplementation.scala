package Services.Implementations

import java.io.IOException
import java.nio.file.{Files, Path, Paths, StandardCopyOption}

import Configurations.FileStorageProperties
import Entities.Mappers.{PassportMapper, PhotoMapper}
import Entities.Passport._
import Services.Traits.PassportService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.dao.EmptyResultDataAccessException
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import java.util.UUID.randomUUID

import scala.collection.JavaConverters._

@Service
class PassportImplementation(@Autowired
                             @Qualifier("mssqlJdbcTemplate")
                             val sqlServerTemplate: JdbcTemplate,

                             @Autowired
                             fileStorageProperties: FileStorageProperties) extends PassportService {

  private val fileStorageLocation: Path = Paths.get(fileStorageProperties.getUploadDir).toAbsolutePath.normalize()

  override def addNewPassport(passport: PassportRequest): Int = {

    val infoAboutPhotos = saveFilesToFileStorage(Array(passport.photoRequest.photoPage1,
      passport.photoRequest.photoPage2,
      passport.photoRequest.photoIDOwner,
      passport.photoRequest.photoOwnerWithPassport,
      passport.photoRequest.photoRegistration))

    val listOfPhotoIndexes = saveInfoAboutFiles(infoAboutPhotos)


    if (listOfPhotoIndexes.size == 5) {
      addPassportToDB(passport, listOfPhotoIndexes)
    }
    else {
      deleteFilesAndInfo(listOfPhotoIndexes)
      -1
    }
  }

  override def removePassport(id: Int): Boolean = {
    val listOfPhotosForDelete = getListOfPhotosForDelete(id)
    deleteFilesAndInfo(listOfPhotosForDelete)
    deleteSomePassport(id)
  }

  override def updatePassport(passport: PassportRequestOnUpdate): Boolean = {
    val sql =
      s"""
         | DECLARE @res Bit = 0
         | EXEC @res = [dbo].[PassportUpdate]
         |  @PassportId =?
         |  ,@PassportCode = ?
         |	,@Series = ?
         |  ,@BirthDay = ?
         |	,@FirstName = ?
         |  ,@LastName = ?
         |
         | SELECT @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, passport.id.toString,
      if (passport.passportCode == null) null else passport.passportCode.toString,
      if (passport.series == null) null else passport.series.toString,
      passport.birthDay,
      passport.firstName,
      passport.lastName
    )

    res
  }

  override def getPassportById(id: Int): PassportResponse = {
    val sql =
      s"""
         | EXEC [dbo].[PassportGet] @PassportId = ?
       """.stripMargin

    try {
      val res: PassportResponse = sqlServerTemplate.queryForObject(sql, new PassportMapper(), id.toString)
      res
    } catch {
      case _: EmptyResultDataAccessException => null
    }
  }

  override def getPassports(): Iterable[PassportResponse] = {
    val sql =
      s"""
         | EXEC [dbo].[PassportGet]
       """.stripMargin

    sqlServerTemplate.query(sql, new PassportMapper()).asScala.toList

  }

  // private methods

  private def saveFilesToFileStorage(files: Array[MultipartFile]): Map[String, String] = {

    var infoAboutFiles: Map[String, String] = Map()

    for (file <- files) {
      try {
        val originalFileName = file.getOriginalFilename
        val fileName = randomUUID().toString + originalFileName.substring(originalFileName.lastIndexOf("."))

        // Copy file to the target location (Replacing existing file with the same name)
        val targetLocation = fileStorageLocation.resolve(fileName)

        Files.copy(file.getInputStream, targetLocation, StandardCopyOption.REPLACE_EXISTING)

        infoAboutFiles += (targetLocation.toString -> originalFileName)
      } catch {
        case ex: IOException => println(ex.getMessage)
      }
    }
    infoAboutFiles
  }

  private def deleteFilesAndInfo(listOfPhotoIndexes: List[Int]): Boolean = {
    val sqlForDelete =
      s"""
         | DECLARE @res BIT = -1
         | EXEC @res = [dbo].[PhotoRemove] @PhotoId = ?
         | SELECT @res
         """.stripMargin
    val sqlForGetPath =
      s"""
         |DECLARE @Id INT = -1
         |EXEC @Id = [dbo].[PhotoGet] @PhotoId = ?
         |SELECT @Id
         """.stripMargin

    var isDeleted: Boolean = true
    listOfPhotoIndexes.foreach {
      index =>
        try {
          val infoAboutImage = sqlServerTemplate.queryForObject(sqlForGetPath, new PhotoMapper(), index.toString)
          isDeleted = Files.deleteIfExists(Paths.get(infoAboutImage.path))

          if (isDeleted) {
            sqlServerTemplate.queryForObject(sqlForDelete, java.lang.Boolean.TYPE, index.toString)
          }
        } catch {
          case e: EmptyResultDataAccessException => println(e.getMessage)
        }
    }
    isDeleted
  }

  private def saveInfoAboutFiles(infoAboutPhotos: Map[String, String]): List[Int] = {
    val sqlForPhotos =
      s"""
         |DECLARE @Index INT = -1
         |EXEC @Index = [dbo].[PhotoAdd]
         |  @Photo_Name = ?
         |  ,@Photo_Path = ?
         |
         |SELECT @Index
         """.stripMargin

    var listOfPhotoIndexes: List[Int] = List()
    infoAboutPhotos.foreach { row =>
      val resIndex = sqlServerTemplate.queryForObject(sqlForPhotos, java.lang.Integer.TYPE,
        row._2, // Name
        row._1 // Path
      )
      listOfPhotoIndexes = resIndex :: listOfPhotoIndexes
    }
    listOfPhotoIndexes
  }

  private def addPassportToDB(passport: PassportRequest, listOfPhotoIndexes: List[Int]): Int = {
    val sql =
      s"""
         | DECLARE @PassportId INT = -1
         | EXEC @PassportId = [dbo].[PassportAdd]
         |	@PassportCode = ?
         |	,@Series = ?
         |  ,@BirthDay = ?
         |	,@FirstName = ?
         |  ,@LastName = ?
         |  ,@PhotoRegistrationId = ?
         |  ,@PhotoOwnerWithPassportId = ?
         |  ,@PhotoIDOwnerId = ?
         |  ,@PhotoPage2Id = ?
         |  ,@PhotoPage1Id = ?
         |
         | select @PassportId
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE,
      passport.passportCode.toString,
      passport.series.toString,
      passport.birthDay,
      passport.firstName,
      passport.lastName,
      listOfPhotoIndexes.head.toString, // PhotoRegistration
      listOfPhotoIndexes(1).toString, // PhotoOwnerWithPassport
      listOfPhotoIndexes(2).toString, // PhotoIDOwner
      listOfPhotoIndexes(3).toString, // PhotoPage2
      listOfPhotoIndexes(4).toString // PhotoPage1
    )

    res.asInstanceOf[Int]
  }

  private def getListOfPhotosForDelete(id: Int): List[Int] = {
    val passport = getPassportById(id)

    List(passport.photoIDOwnerId,
      passport.PhotoOwnerWithPassportId,
      passport.photoPage1Id,
      passport.photoPage2Id,
      passport.photoRegistrationId)
  }

  private def deleteSomePassport(id: Int): Boolean = {
    val sql =
      s"""
         | DECLARE @res INT = 0
         | EXEC @res = [dbo].[PassportRemove]
         |	@PassportId = ?
         |
         | select @res
       """.stripMargin

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE,
      id.toString,
    )

    res.asInstanceOf[Boolean]
  }
}
