package Controllers.DataLakeControllers

import Entities.Tournament
import Services.Traits.TournamentService
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._

import scala.collection.JavaConverters._

@RestController
@RequestMapping(path = Array("/api/data/tournament"))
class TournamentsController(
                             @Autowired
                             tournamentService: TournamentService
                           )  {
  // add new tournament [ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def addNewTournament(@RequestBody
                 tournament: Tournament): Int = {
    tournamentService.addNewTournament(tournament)
  }

  // update tournament [ Method = PUT ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.PUT))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def updateTournament(@RequestBody
                 tournament: Tournament): Boolean = {
    tournamentService.updateTournament(tournament)
  }

  // delete tournament [ Method = DELETE ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.DELETE))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def removeTournament(@PathVariable("id")
                 id: Int, response: HttpServletResponse): Boolean = {
    val result: Boolean = tournamentService.removeTournament(id)

    if (!result) {
      response.setStatus(HttpServletResponse.SC_NOT_FOUND)
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tournament not found!")
    }
    result
  }

  // get tournament by id [ Method = GET ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getTournamentById(@PathVariable("id")
                  id: Int): Tournament = {
    tournamentService.getTournamentById(id)
  }

  // get all tournament [ Method = GET ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getAllTournaments(): java.util.List[Tournament] = {
    tournamentService.getTournaments().toList.asJava

  }
}
