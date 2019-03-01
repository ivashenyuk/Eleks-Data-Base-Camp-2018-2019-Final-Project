package Services.Traits

import Entities.Bank

trait BankService {
  def addNewBank(bank: Bank): Int
  def removeBank(id: Int): Boolean
  def updateBank(bank: Bank): Boolean
  def getBankById(id: Int): Bank
  def getBanks(): Iterable[Bank]
}
