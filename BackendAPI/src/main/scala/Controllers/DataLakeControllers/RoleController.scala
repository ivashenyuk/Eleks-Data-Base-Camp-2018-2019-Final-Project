package Controllers.DataLakeControllers

import Entities.Role
import Services.Traits.RoleService
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._
import scala.collection.JavaConverters._

@RestController
@RequestMapping(path = Array("/api/data/role"))
class RoleController(
                      @Autowired
                      roleService: RoleService
                    ) {
  // add new role [ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def addNewRole(@RequestBody
                 role: Role): Int = {
    roleService.addNewRole(role)
  }

  // update role [ Method = PUT ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.PUT))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def updateRole(@RequestBody
                 role: Role): Boolean = {
    roleService.updateRole(role)
  }

  // delete role [ Method = DELETE ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.DELETE))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def removeRole(@PathVariable("id")
                 id: Int, response: HttpServletResponse): Boolean = {
    val result: Boolean = roleService.removeRole(id)

    if (!result) {
      response.setStatus(HttpServletResponse.SC_NOT_FOUND)
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "Role not found!")
    }
    result
  }

  // get role by id [ Method = GET ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getRoleById(@PathVariable("id")
                  id: Int): Role = {
    roleService.getRoleById(id)
  }

  // get all role [ Method = GET ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getAllRoles(): java.util.List[Role] = {
    roleService.getRoles().toList.asJava
  }
}
