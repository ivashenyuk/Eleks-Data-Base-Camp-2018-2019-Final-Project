package Entities



import java.sql.Date

import org.codehaus.jackson.annotate.JsonIgnoreProperties
import org.codehaus.jackson.map.annotate.JsonSerialize

import scala.beans.BeanProperty


@JsonIgnoreProperties(ignoreUnknown = true)
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
case class User(
                 @BeanProperty
                 id: Int,
                 @BeanProperty
                 roleId: Int,
                 @BeanProperty
                 locationId: Int,
                 @BeanProperty
                 userGroupId: Int,
                 @BeanProperty
                 firstName: String,
                 @BeanProperty
                 lastName: String,
                 @BeanProperty
                 birthDay: Date,
                 @BeanProperty
                 email: String,
                 @BeanProperty
                 phone: String,
                 @BeanProperty
                 password: String,
                 @BeanProperty
                 age: Int,

                 @BeanProperty
                 emailIsConfirmed: Boolean,
                 @BeanProperty
                 phoneIsConfirmed: Boolean,
                 @BeanProperty
                 isConfirmedAdministrations: Boolean,
                 @BeanProperty
                 language: String
               ) {}
