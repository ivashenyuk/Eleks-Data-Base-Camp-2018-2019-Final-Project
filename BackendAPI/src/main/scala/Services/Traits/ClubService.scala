package Services.Traits

import Entities.Club

trait ClubService {
  def addNewClub(club: Club): Int
  def removeClub(id: Int): Boolean
  def updateClub(club: Club): Boolean
  def getClubById(id: Int): Club
  def getClubs(): Iterable[Club]
}
