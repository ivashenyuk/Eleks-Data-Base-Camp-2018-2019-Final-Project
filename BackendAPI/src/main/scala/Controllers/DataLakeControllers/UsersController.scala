package Controllers.DataLakeControllers

import Entities.User
import Services.Traits.UserService
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._

@RestController
@RequestMapping(path = Array("/api/data/user"))
class UsersController(
                       @Autowired
                       userService: UserService
                     ) {
  // registration user [ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def registration(@RequestBody
                   user: User): Int = {
    userService.registration(user)
  }

  // delete user account [ Method = DELETE ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.DELETE))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def deleteAccount(@PathVariable("id")
                    id: Int, response: HttpServletResponse): Boolean = {
    val result: Boolean = userService.deleteAccount(id)

    if (!result) {
      response.setStatus(HttpServletResponse.SC_NOT_FOUND)
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found!")
    }
    result
  }

  // update information user [ Method = PUT ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.PUT))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def updateUser(@RequestBody
                        user: User): Boolean = {
    userService.updateUser(user)
  }
}
