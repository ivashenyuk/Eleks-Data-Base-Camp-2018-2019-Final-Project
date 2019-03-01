package Services.Implementations

import Entities.User
import Helpers.MD5
import Services.Traits.UserService
import org.springframework.beans.factory.annotation.{Autowired, Qualifier}
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

@Service
class UserImplementation(@Autowired
                         @Qualifier("mssqlJdbcTemplate")
                         val sqlServerTemplate: JdbcTemplate) extends UserService {
  override def registration(user: User): Int = {
    createUser(user)
  }

  override def deleteAccount(id: Int): Boolean = {
    deleteUserAccount(id)
  }

  override def updateUser(user: User): Boolean = {
    updateUserPrivate(user)
  }


  // private methods

  private def createUser(user: User): Int = {
    val sql =
      s"""
          declare @result int = -1
          exec @result = [dbo].[UserRegistration]
            @FirstName = ?
            , @LastName = ?
            , @BirthDay = ?
            , @Email = ?
            , @Phone = ?
            , @HashPassword = ?
            , @Language = ?
            , @UserGroupId = ?

            select @result
      """

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Integer.TYPE,
      user.firstName,
      user.lastName,
      user.birthDay,
      user.email,
      user.phone,
      MD5.hash(user.password),
      user.language,
      user.userGroupId.toString)

    res.asInstanceOf[Int]
  }

  private def deleteUserAccount(id: Int): Boolean = {
    val sql =
      s"""
          declare @result Bit = 0
          exec @result = [dbo].[UserDelete]
            @UserId = ?

            select @result
      """

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE, id.toString)
    res
  }
  private def updateUserPrivate(user: User): Boolean = {
    val sql =
      s"""
          declare @result int = 0
          exec @result = [dbo].[UserUpdate]
            @UserId = ?
            , @BirthDay = ?
            , @Email = ?
            , @Phone = ?
            , @HashPassword = ?
            , @Language = ?
            , @RoleId = ?
            , @EmailIsConfirmed = ?
            , @PhoneIsConfirmed = ?
            , @IsConfirmedAdministrations = ?
            , @LocationId = ?
            , @UserGroupId = ?

            select @result
      """

    val res = sqlServerTemplate.queryForObject(sql, java.lang.Boolean.TYPE,
      user.id.toString,
      user.birthDay,
      user.email,
      user.phone,
      MD5.hash(user.password),
      user.language,
      user.roleId.toString,
      user.emailIsConfirmed.toString,
      user.phoneIsConfirmed.toString,
      user.isConfirmedAdministrations.toString,
      user.locationId.toString,
      user.userGroupId.toString)

    res
  }
}
