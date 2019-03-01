package Services.Traits

import Entities.Location

trait  LocationService {
  def addNewLocation(location: Location): Int
  def removeLocation(id: Int): Boolean
  def updateLocation(location: Location): Boolean
  def getLocationById(id: Int): Location
  def getLocations(): Iterable[Location]
}
