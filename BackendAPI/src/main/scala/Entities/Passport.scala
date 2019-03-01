package Entities

import Entities.Photos._
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.JsonSerialize

import scala.beans.BeanProperty


object Passport {

  @JsonIgnoreProperties(ignoreUnknown = true)
  @JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
  case class PassportResponse(
                               @BeanProperty
                               id: Int,

                               @BeanProperty
                               passportCode: Int,

                               @BeanProperty
                               series: String,

                               @BeanProperty
                               birthDay: java.sql.Date,

                               @BeanProperty
                               FirstName: String,

                               @BeanProperty
                               LastName: String,

                               @BeanProperty
                               photoPage1Id: Int,

                               @BeanProperty
                               photoPage2Id: Int,

                               @BeanProperty
                               photoRegistrationId: Int,

                               @BeanProperty
                               photoIDOwnerId: Int,

                               @BeanProperty
                               PhotoOwnerWithPassportId: Int
                             ) {}

  case class PassportRequest(
                              passportCode: java.lang.Integer,
                              series: String,
                              birthDay: java.sql.Date,
                              firstName: String,
                              lastName: String,
                              photoRequest: PhotoRequest
                            ) {}

  @JsonIgnoreProperties(ignoreUnknown = true)
  @JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
  case class PassportRequestOnUpdate(
                                      @BeanProperty
                                      id: Int,

                                      @BeanProperty
                                      passportCode: java.lang.Integer,

                                      @BeanProperty
                                      series: String,

                                      @BeanProperty
                                      birthDay: java.sql.Date,

                                      @BeanProperty
                                      firstName: String,

                                      @BeanProperty
                                      lastName: String
                                    ) {}

}