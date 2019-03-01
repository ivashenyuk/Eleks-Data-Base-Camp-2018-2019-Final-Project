CREATE PROCEDURE [dbo].[UserRegistration]
	@FirstName NVARCHAR(255)
	,@LastName NVARCHAR(255)
	,@BirthDay DATE
	,@Email NVARCHAR(100)
	,@Phone NVARCHAR(15)
	,@HashPassword  NVARCHAR(200)
	,@EmailIsConfirmed BIT = 0
	,@PhoneIsConfirmed BIT = 0
	,@IsConfirmedAdministrations BIT = 0
	,@Language NVARCHAR(255) = N'English'
	,@Currency VARCHAR(3) = 'USD'
	,@UserGroupId INT = 1
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	DECLARE @UserId INT = -1
	BEGIN TRAN
		BEGIN TRY
			-- Creating user passport
			INSERT INTO [dbo].[Passports]([FirstName], [LastName], [BirthDay]) VALUES (@FirstName, @LastName, @BirthDay)
			DECLARE @PassportId INT = SCOPE_IDENTITY()
					,@Age INT = DATEDIFF ( YEAR , @BirthDay, GETDATE()) - (CASE WHEN GETDATE() < DATEADD(yyyy,DATEDIFF(yyyy,@BirthDay,GETDATE()),@BirthDay) THEN 1 ELSE 0 END)
			
			-- Creating user purse
			INSERT INTO [dbo].[Purses]([Currency]) VALUES (@Currency)
			DECLARE @PurseId INT = SCOPE_IDENTITY()

			-- Creatin user account
			INSERT INTO [dbo].[Users]( [PassportId]
									, [PurseId]
									, [RoleId]
									, [Email]
									, [Phone]
									, [HashPassword]
									, [Language]
									, [Age]
									, [EmailIsConfirmed]
									, [PhoneIsConfirmed]
									, [IsConfirmedAdministrations]
									, [UserGroupId]) 
									VALUES (@PassportId
											, @PurseId
											, 2 -- Default user
											, @Email
											, @Phone
											, @HashPassword
											, @Language
											, @Age
											, @EmailIsConfirmed
											, @PhoneIsConfirmed
											, @IsConfirmedAdministrations
											, @UserGroupId
											)

			SET @UserId = SCOPE_IDENTITY()

			COMMIT
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN
				ROLLBACK
				;THROW

			END
				
		END CATCH

	

	RETURN @UserId
END
