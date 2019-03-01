package Services.Traits

import Entities.User
import org.springframework.stereotype.Service


trait UserService {
  def registration(user: User): Int
  def deleteAccount(id: Int): Boolean
  def updateUser(user: User): Boolean
}
