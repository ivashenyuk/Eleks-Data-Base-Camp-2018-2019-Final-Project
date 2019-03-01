package Services.Traits

import Entities.BetResponse

trait BetService {
  def getBetById(id: Int): BetResponse

  def getBets(): Iterable[BetResponse]
}
