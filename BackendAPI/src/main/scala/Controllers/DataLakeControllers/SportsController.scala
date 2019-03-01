package Controllers.DataLakeControllers

import Entities.Sport
import Services.Traits.SportService
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._

import scala.collection.JavaConverters._

@RestController
@RequestMapping(path = Array("/api/data/sport"))
class SportsController(
                        @Autowired
                        sportService: SportService
                      ) {
  // add new sport [ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def addNewSport(@RequestBody
                 sport: Sport): Int = {
    sportService.addNewSport(sport)
  }

  // update sport [ Method = PUT ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.PUT))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def updateSport(@RequestBody
                 sport: Sport): Boolean = {
    sportService.updateSport(sport)
  }

  // delete sport [ Method = DELETE ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.DELETE))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def removeSport(@PathVariable("id")
                 id: Int, response: HttpServletResponse): Boolean = {
    val result: Boolean = sportService.removeSport(id)

    if (!result) {
      response.setStatus(HttpServletResponse.SC_NOT_FOUND)
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sport not found!")
    }
    result
  }

  // get sport by id [ Method = GET ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getSportById(@PathVariable("id")
                  id: Int): Sport = {
    sportService.getSportById(id)
  }

  // get all sport [ Method = GET ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getAllSports(): java.util.List[Sport] = {
    sportService.getSports().toList.asJava

  }
}
