package Entities

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import org.springframework.web.multipart.MultipartFile

import scala.beans.BeanProperty


object Photos {

  case class Photo(id: Int, defaultFileName: String, path: String) {}


  case class PhotoRequest(
                           photoPage1: MultipartFile,
                           photoPage2: MultipartFile,
                           photoRegistration: MultipartFile,
                           photoIDOwner: MultipartFile,
                           photoOwnerWithPassport: MultipartFile
                         )

  @JsonIgnoreProperties(ignoreUnknown = true)
  @JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
  case class PhotosForDownload(
                                @BeanProperty
                                photoPage1: String,

                                @BeanProperty
                                photoPage2: String,

                                @BeanProperty
                                photoRegistration: String,

                                @BeanProperty
                                photoIDOwner: String,

                                @BeanProperty
                                photoOwnerWithPassport: String
                              )

}