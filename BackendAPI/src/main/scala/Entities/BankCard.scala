package Entities

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.annotation.JsonSerialize

import scala.beans.BeanProperty

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class BankCard(
                     @BeanProperty
                     id: Int,

                     @BeanProperty
                     userId: Int,

                     @BeanProperty
                     bankId: Int,

                     @BeanProperty
                     cardNumber: String,

                     @BeanProperty
                     expiryDateCard: java.sql.Date,

                     @BeanProperty
                     digitsOnBackOfCard: Short,

                     @BeanProperty
                     isConfirmedCard: Boolean
                   ) {}
