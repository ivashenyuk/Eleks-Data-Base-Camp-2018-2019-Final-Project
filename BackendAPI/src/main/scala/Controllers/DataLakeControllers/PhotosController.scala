package Controllers.DataLakeControllers

import Configurations.FileStorageProperties
import Entities.Photos._
import Services.Traits.PhotoService
import javax.servlet.http.{HttpServletRequest, HttpServletResponse}
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.{HttpStatus, MediaType}
import org.springframework.web.bind.annotation._
import org.springframework.http.HttpHeaders
import org.springframework.http.ResponseEntity
import java.io.IOException

import org.springframework.core.io.Resource

@RestController
@RequestMapping(path = Array(""))
class PhotosController(
                        @Autowired
                        photoService: PhotoService,

                        @Autowired
                        fileStorageProperties: FileStorageProperties
                      ) {

  // delete photo [ Method = DELETE ]
  @RequestMapping(
    path = Array("/api/data/photo/{id:[\\d]+}"),
    method = Array(RequestMethod.DELETE))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def removePhoto(@PathVariable("id")
                  id: Int, response: HttpServletResponse): Boolean = {
    val result: Boolean = photoService.removePhotoById(id)

    if (!result) {
      response.setStatus(HttpServletResponse.SC_NOT_FOUND)
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "Photo not found!")
    }
    result
  }

  // get photos by passport id [ Method = GET ]
  @RequestMapping(
    path = Array("/api/data/photo/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getPhotosById(@PathVariable("id")
                    id: Int): PhotosForDownload = {
    photoService.getUrlsOfDownload(id)
  }

  // get photos by passport id [ Method = GET ]
  @RequestMapping(
    path = Array("/PhotosOfPassports/{fileName}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getPhotoResource(@PathVariable("fileName")
                       fileName: String, request: HttpServletRequest): ResponseEntity[Resource] = {

    // Load file as Resource// Load file as Resource

    val resource = photoService.loadFileAsResource(fileName)

    // Try to determine file's content type
    var contentType: String = null
    try
      contentType = request.getServletContext.getMimeType(resource.getFile.getAbsolutePath)
    catch {
      case _: IOException =>
        println("Could not determine file type.")
    }

    // Fallback to the default content type if type could not be determined
    if (contentType == null) contentType = "application/octet-stream"

    ResponseEntity
      .ok
      .contentType(MediaType.parseMediaType(contentType))
      .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename + "\"")
      .body(resource)
  }

}
