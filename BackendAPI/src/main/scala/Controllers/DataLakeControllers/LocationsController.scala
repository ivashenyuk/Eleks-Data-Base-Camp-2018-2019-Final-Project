package Controllers.DataLakeControllers

import Entities.Location
import Services.Traits.LocationService
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._

import scala.collection.JavaConverters._

@RestController
@RequestMapping(path = Array("/api/data/location"))
class LocationsController(
                       @Autowired
                       locationService: LocationService
                     ) {
  // add new location [ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def addNewLocation(@RequestBody
                 location: Location): Int = {
    locationService.addNewLocation(location)
  }

  // update location [ Method = PUT ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.PUT))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def updateLocation(@RequestBody
                 location: Location): Boolean = {
    locationService.updateLocation(location)
  }

  // delete location [ Method = DELETE ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.DELETE))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def removeLocation(@PathVariable("id")
                 id: Int, response: HttpServletResponse): Boolean = {
    val result: Boolean = locationService.removeLocation(id)

    if (!result) {
      response.setStatus(HttpServletResponse.SC_NOT_FOUND)
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "Location not found!")
    }
    result
  }

  // get location by id [ Method = GET ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getLocationById(@PathVariable("id")
                  id: Int): Location = {
    locationService.getLocationById(id)
  }

  // get all location [ Method = GET ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getAllLocations(): java.util.List[Location] = {
    locationService.getLocations().toList.asJava

  }
}
