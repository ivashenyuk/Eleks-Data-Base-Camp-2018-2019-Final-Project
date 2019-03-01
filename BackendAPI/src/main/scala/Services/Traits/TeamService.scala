package Services.Traits

import Entities.Team

trait TeamService {
  def addNewTeam(team: Team): Int
  def removeTeam(id: Int): Boolean
  def updateTeam(team: Team): Boolean
  def getTeamById(id: Int): Team
  def getTeams(): Iterable[Team]
}
