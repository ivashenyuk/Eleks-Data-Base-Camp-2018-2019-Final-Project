package Services.Traits

import Entities.Sport

trait SportService {
  def addNewSport(sport: Sport): Int
  def removeSport(id: Int): Boolean
  def updateSport(sport: Sport): Boolean
  def getSportById(id: Int): Sport
  def getSports(): Iterable[Sport]
}
