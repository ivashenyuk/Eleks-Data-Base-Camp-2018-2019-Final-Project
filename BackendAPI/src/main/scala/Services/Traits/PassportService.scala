package Services.Traits

import Entities.Passport._

trait PassportService {
  def addNewPassport(passport: PassportRequest): Int
  def removePassport(id: Int): Boolean
  def updatePassport(passport: PassportRequestOnUpdate): Boolean
  def getPassportById(id: Int): PassportResponse
  def getPassports(): Iterable[PassportResponse]
}
