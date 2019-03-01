package Services.Traits

import Entities.Match

trait MatchService {
  def addNewMatch(matchEntity: Match): Int
  def removeMatch(id: Int): Boolean
  def updateMatch(matchEntity: Match): Boolean
  def getMatchById(id: Int): Match
  def getMatches(): Iterable[Match]
}
