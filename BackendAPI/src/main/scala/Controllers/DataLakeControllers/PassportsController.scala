package Controllers.DataLakeControllers

import Entities.Passport._
import Entities.Photos._
import Services.Traits.PassportService
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._
import org.springframework.web.multipart.MultipartFile

import scala.collection.JavaConverters._

@RestController
@RequestMapping(path = Array("/api/data/passport"))
class PassportsController(
                           @Autowired
                           passportService: PassportService
                         ) {

  // add new passport [ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("multipart/mixed"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def addNewPassport(@RequestParam("passportCode")
                     passportCode: Int,
                     @RequestParam("series")
                     series: String,
                     @RequestParam("birthDay")
                     birthDay: java.sql.Date,
                     @RequestParam("firstName")
                     firstName: String,
                     @RequestParam("lastName")
                     lastName: String,
                     @RequestParam("photoPage1")
                     photoPage1: MultipartFile,
                     @RequestParam("photoPage2")
                     photoPage2: MultipartFile,
                     @RequestParam("photoRegistrationId")
                     photoRegistrationId: MultipartFile,
                     @RequestParam("photoIDOwnerId")
                     photoIDOwnerId: MultipartFile,
                     @RequestParam("photoOwnerWithPassportId")
                     photoOwnerWithPassportId: MultipartFile,
                     response: HttpServletResponse): Int = {

    val passport = PassportRequest(passportCode, series, birthDay, firstName, lastName,
      PhotoRequest(photoPage1, photoPage2, photoRegistrationId, photoIDOwnerId, photoOwnerWithPassportId))

    val passportId = passportService.addNewPassport(passport)

    if(passportId == -1){
      response.setStatus(HttpServletResponse.SC_CONFLICT)
      response.sendError(HttpServletResponse.SC_CONFLICT, "Try again upload photos!")
    }

    passportId
  }

  // update passport [ Method = PUT ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.PUT))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def updatePassport(@RequestBody
                     passport: PassportRequestOnUpdate): Boolean = {
    passportService.updatePassport(passport)
  }

  // delete passport [ Method = DELETE ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.DELETE))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def removePassport(@PathVariable("id")
                     id: Int, response: HttpServletResponse): Boolean = {
    val result: Boolean = passportService.removePassport(id)

    if (!result) {
      response.setStatus(HttpServletResponse.SC_NOT_FOUND)
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "Passport not found!")
    }
    result
  }

  // get passport by id [ Method = GET ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getPassportById(@PathVariable("id")
                      id: Int): PassportResponse = {
    passportService.getPassportById(id)
  }

  // get all passport [ Method = GET ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getAllPassports(): java.util.List[PassportResponse] = {
    passportService.getPassports().toList.asJava

  }
}

