CREATE PROCEDURE [dbo].[UserUpdate]
	@UserId INT
	,@BirthDay DATE = NULL
	,@Email NVARCHAR(100) = NULL
	,@Phone NVARCHAR(15) = NULL
	,@HashPassword  NVARCHAR(200) = NULL
	,@EmailIsConfirmed BIT = NULL
	,@PhoneIsConfirmed BIT = NULL
	,@IsConfirmedAdministrations BIT = NULL
	,@Language NVARCHAR(255) = NULL
	,@RoleId INT = NULL
	,@LocationId INT = NULL
	,@UserGroupId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@UserId IS NULL)
				THROW 51000, 'User ID can''t be empty.', 1;
			
			
			DECLARE @Age INT = NULL
					
			IF (@BirthDay IS NOT NULL)
					SET @Age = DATEDIFF ( YEAR , @BirthDay, GETDATE()) - (CASE WHEN GETDATE() < DATEADD(yyyy,DATEDIFF(yyyy,@BirthDay,GETDATE()),@BirthDay) THEN 1 ELSE 0 END)

			--DECLARE @PassportId INT = NULL
			--		,@PurseId INT = NULL
			--SELECT TOP 1 @PassportId = [PassportId], @PurseId = [PurseId] FROM [dbo].[Users] WHERE [Id] = @UserId

			---- updating user passport
			--UPDATE [dbo].[Passports] 
			--	SET [FirstName] = N''
			--	, [LastName]  = N''
			--	, [BirthDay]  = N''
			--	WHERE [Id] = @PassportId
				
			
					
			
			---- updating user purse
			--IF (@PurseId IS NOT NULL)
			--	UPDATE [dbo].[Purses] SET [Currency] = @Currency WHERE [Id] = @PurseId
			
			-- updating user account
			UPDATE [dbo].[Users] SET 
									[RoleId] = ISNULL(NULLIF(@RoleId, 0), [RoleId])
									, [Email] = ISNULL(@Email, [Email])
									, [Phone] = ISNULL(@Phone, [Phone])
									, [HashPassword] = ISNULL(@HashPassword, [HashPassword])
									, [Language] = ISNULL(@Language, [Language])
									, [Age] = ISNULL(@Age, [Age])
									, [EmailIsConfirmed] = ISNULL(@EmailIsConfirmed, [EmailIsConfirmed])
									, [PhoneIsConfirmed] = ISNULL(@PhoneIsConfirmed, [PhoneIsConfirmed])
									, [IsConfirmedAdministrations] = ISNULL(@IsConfirmedAdministrations, [IsConfirmedAdministrations])
									, [UserGroupId] =  ISNULL(@EmailIsConfirmed, [UserGroupId])
									WHERE [Id] = @UserId
			COMMIT
			RETURN 1
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN
				ROLLBACK
				;THROW
			END
			RETURN 0
		END CATCH	
END
