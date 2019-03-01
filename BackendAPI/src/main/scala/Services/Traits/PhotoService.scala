package Services.Traits

import Entities.Photos._
import org.springframework.core.io.Resource

trait PhotoService {
  def getUrlsOfDownload(passportId: Int): PhotosForDownload
  def removePhotoById(id: Int): Boolean
  def loadFileAsResource(fileName: String): Resource
}
