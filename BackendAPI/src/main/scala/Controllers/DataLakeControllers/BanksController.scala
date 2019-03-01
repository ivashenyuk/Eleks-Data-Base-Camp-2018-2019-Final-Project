package Controllers.DataLakeControllers

import Entities.{Bank, Club}
import Services.Traits.{BankService, ClubService}
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._
import scala.collection.JavaConverters._

@RestController
@RequestMapping(path = Array("/api/data/bank"))
class BanksController (
                        @Autowired
                        bankService: BankService
                      ) {
  // add new bank [ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def addNewBank(@RequestBody
                 bank: Bank): Int = {
    bankService.addNewBank(bank)
  }

  // update bank [ Method = PUT ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.PUT))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def updateBank(@RequestBody
                 bank: Bank): Boolean = {
    bankService.updateBank(bank)
  }

  // delete bank [ Method = DELETE ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.DELETE))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def removeBank(@PathVariable("id")
                 id: Int, response: HttpServletResponse): Boolean = {
    val result: Boolean = bankService.removeBank(id)

    if (!result) {
      response.setStatus(HttpServletResponse.SC_NOT_FOUND)
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bank not found!")
    }
    result
  }

  // get bank by id [ Method = GET ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getBankById(@PathVariable("id")
                  id: Int): Bank = {
    bankService.getBankById(id)
  }

  // get all banks [ Method = GET ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getAllBanks(): java.util.List[Bank] = {
    bankService.getBanks().toList.asJava

  }
}
