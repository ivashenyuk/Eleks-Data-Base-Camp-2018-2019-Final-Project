package Services.Traits

import Entities.Tournament

trait TournamentService {
  def addNewTournament(tournament: Tournament): Int
  def removeTournament(id: Int): Boolean
  def updateTournament(tournament: Tournament): Boolean
  def getTournamentById(id: Int): Tournament
  def getTournaments(): Iterable[Tournament]
}
