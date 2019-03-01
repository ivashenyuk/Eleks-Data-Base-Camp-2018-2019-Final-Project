package Controllers.DataLakeControllers

import Entities.BankCard
import Services.Traits.BankCardService
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation._
import scala.collection.JavaConverters._

@RestController
@RequestMapping(path = Array("/api/data/bankCard"))
class BankCardController (
                           @Autowired
                           bankCardService: BankCardService
                         ) {
  // add new bankCard [ Method = POST ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.POST))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def addNewBankCard(@RequestBody
                 bankCard: BankCard): Int = {
    bankCardService.addNewBankCard(bankCard)
  }

  // update bankCard [ Method = PUT ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.PUT))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def updateBankCard(@RequestBody
                 bankCard: BankCard): Boolean = {
    bankCardService.updateBankCard(bankCard)
  }

  // delete bankCard [ Method = DELETE ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.DELETE))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def removeBankCard(@PathVariable("id")
                 id: Int, response: HttpServletResponse): Boolean = {
    val result: Boolean = bankCardService.removeBankCard(id)

    if (!result) {
      response.setStatus(HttpServletResponse.SC_NOT_FOUND)
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "BankCard not found!")
    }
    result
  }

  // get bankCard by id [ Method = GET ]
  @RequestMapping(
    path = Array("/{id:[\\d]+}"),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getBankCardById(@PathVariable("id")
                  id: Int): BankCard = {
    bankCardService.getBankCardById(id)
  }

  // get all bankCards [ Method = GET ]
  @RequestMapping(
    path = Array(""),
    method = Array(RequestMethod.GET))
  @PostMapping(produces = Array("application/json"))
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  def getAllBankCards(): java.util.List[BankCard] = {
    bankCardService.getBankCards().toList.asJava

  }
}
