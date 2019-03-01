package Services.Traits

import Entities.Role

trait RoleService {
  def addNewRole(role: Role): Int
  def removeRole(id: Int): Boolean
  def updateRole(role: Role): Boolean
  def getRoleById(id: Int): Role
  def getRoles(): Iterable[Role]
}
