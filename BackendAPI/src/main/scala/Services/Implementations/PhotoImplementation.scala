package Services.Implementations

import java.net.MalformedURLException
import java.nio.file.{Path, Paths}

import Configurations.FileStorageProperties
import Entities.Photos._
import Services.Traits.PhotoService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.core.io.{Resource, UrlResource}
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service
import org.springframework.web.servlet.support.ServletUriComponentsBuilder
import scala.collection.JavaConverters._

@Service
class PhotoImplementation(@Autowired
                          @Qualifier("mssqlJdbcTemplate")
                          val sqlServerTemplate: JdbcTemplate,

                          @Autowired
                          fileStorageProperties: FileStorageProperties) extends PhotoService {

  private val fileStorageLocation: Path = Paths.get(fileStorageProperties.getUploadDir).toAbsolutePath.normalize()


  override def getUrlsOfDownload(passportId: Int): PhotosForDownload = {
    val collectionNames = getCollectionPaths(passportId)

    getLinksOnPhotos(collectionNames)
  }

  override def removePhotoById(id: Int): Boolean = {
    val sql =
      s"""
         | DECLARE @res BIT = 0
         | EXEC @res = [dbo].[PhotoRemove] @PhotoId = ?
         | SELECT @res
       """.stripMargin

    val isDeleted = sqlServerTemplate.queryForObject(sql, classOf[ Boolean], id.toString)
    isDeleted
  }

  override def loadFileAsResource(fileName: String): Resource = {

    try {

      val filePath = fileStorageLocation.resolve(fileName).normalize
      val resource = new UrlResource(filePath.toUri)
      //      resource.
      if (resource.exists) resource
      else throw new Exception("File not found " + fileName)
    } catch {
      case ex: MalformedURLException =>
        throw new Exception("File not found " + fileName, ex)
    }
  }

  // private methods

  private def getCollectionPaths(passportId: Int): List[String] = {
    val sql =
      s"""
         | EXEC PhotoGetCollectionPathByPassportId @PassportId = ?
       """.stripMargin

    val collectionPaths = sqlServerTemplate.queryForList(sql, classOf[String], passportId.toString).asScala.toList

    collectionPaths.map(path => Paths.get(path).getFileName.toString)
  }

  private def getLinksOnPhotos(collectionNames: List[String]): PhotosForDownload = {

    var listNames: List[String] = List()

    for(fileName <- collectionNames) {
      val fileDownloadUri: String = ServletUriComponentsBuilder.fromCurrentContextPath()
        .path(fileStorageProperties.getUploadDir)
        .path(fileName)
        .toUriString

      listNames = fileDownloadUri :: listNames
    }

    PhotosForDownload(listNames.head,
      listNames(1),
      listNames(2),
      listNames(3),
      listNames(4)
    )
  }
}
