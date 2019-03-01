package Controllers.DataLakeControllers

import Entities.Club
import Services.Traits.ClubService
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._

import scala.collection.JavaConverters._

@RestController
@RequestMapping(path = Array("/api/data/club"))
class ClubsController (
                        @Autowired
                        clubService: ClubService
                      ) {
  // add new club [ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def addNewClub(@RequestBody
                 club: Club): Int = {
    clubService.addNewClub(club)
  }

  // update club [ Method = PUT ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.PUT))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def updateClub(@RequestBody
                 club: Club): Boolean = {
    clubService.updateClub(club)
  }

  // delete club [ Method = DELETE ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.DELETE))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def removeClub(@PathVariable("id")
                 id: Int, response: HttpServletResponse): Boolean = {
    val result: Boolean = clubService.removeClub(id)

    if (!result) {
      response.setStatus(HttpServletResponse.SC_NOT_FOUND)
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "Club not found!")
    }
    result
  }

  // get club by id [ Method = GET ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getClubById(@PathVariable("id")
                  id: Int): Club = {
    clubService.getClubById(id)
  }

  // get all club [ Method = GET ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getAllClubs(): java.util.List[Club] = {
    clubService.getClubs().toList.asJava

  }
}
