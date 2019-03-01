package Services.Traits

import Entities.EventResponse

trait EventService {
  def getEventById(id: Int): EventResponse

  def getEvents(): Iterable[EventResponse]
}
