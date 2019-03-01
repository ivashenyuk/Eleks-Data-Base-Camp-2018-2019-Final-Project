package Services.Traits

import Entities.BankCard

trait BankCardService {
  def addNewBankCard(bankCard: BankCard): Int
  def removeBankCard(id: Int): Boolean
  def updateBankCard(bankCard: BankCard): Boolean
  def getBankCardById(id: Int): BankCard
  def getBankCards(): Iterable[BankCard]
}
