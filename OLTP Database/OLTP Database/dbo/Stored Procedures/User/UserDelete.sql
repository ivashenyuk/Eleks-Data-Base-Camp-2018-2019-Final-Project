CREATE PROCEDURE [dbo].[UserDelete]
	@UserId INT
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			DECLARE @PurseId INT,
					@PassportId INT,
					@BankCardId INT
			SELECT TOP 1 @PurseId = [user].[PurseId], 
							@PassportId = [user].[PassportId],
							@BankCardId = [user].[BankCardId] 
								FROM [dbo].[Users] AS [user] WHERE [user].[Id] = @UserId 

			--deleting user account
			DELETE FROM [dbo].[Users] WHERE [Id] = @UserId

			-- deleting user purse
			IF(ISNULL(@PurseId, 0) <> 0)
				DELETE FROM [dbo].[Purses] WHERE [Id] = @PurseId
		
			-- deleting user bank card
			IF(ISNULL(@BankCardId, 0) <> 0)
				DELETE FROM [dbo].[BankCards] WHERE [Id] = @BankCardId

			-- deleting user passport and photos
			IF(ISNULL(@PassportId, 0) <> 0)
				BEGIN 
					DECLARE @UserPhotosId TABLE (
						[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1)
						,[PhotoId] INT NULL
					)

					INSERT INTO @UserPhotosId([PhotoId]) 
						SELECT [PhotoId]
							FROM ( SELECT TOP 1 [passport].[Id]
										,[passport].[PhotoPage1Id]
										,[passport].[PhotoPage2Id]
										,[passport].[PhotoIDOwnerId]
										,[passport].[PhotoOwnerWithPassportId]
										,[passport].[PhotoRegistrationId] 
										FROM [dbo].[Passports] AS [passport]
										WHERE [passport].[Id] = @PassportId
									) AS passPhotos
									UNPIVOT (
										PhotoId FOR TempPhotoName
											IN([PhotoPage1Id], [PhotoPage2Id], [PhotoIDOwnerId]
												,[PhotoOwnerWithPassportId], [PhotoRegistrationId] )

									) AS [unpivot]
					--deleting user photos
					DELETE FROM [dbo].[Photos] WHERE [Id] IN (SELECT [PhotoId] FROM @UserPhotosId) 
				
					--deleting user passport
					DELETE FROM [dbo].[Passports] WHERE [Id] = @PassportId
				END

			COMMIT
			IF (ISNULL(@PurseId, 0) <> 0)
				RETURN 1
			ELSE
				RETURN 0
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