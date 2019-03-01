CREATE PROCEDURE [dbo].[PassportUpdate]
	@PassportId INT
	,@PassportCode VARCHAR(15) = NULL
	,@Series  NVARCHAR(5) = NULL
	,@BirthDay DATE = NULL
	,@FirstName NVARCHAR(255) = NULL
	,@LastName NVARCHAR(255) = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Passports] SET [PassportCode] = ISNULL(@PassportCode, [PassportCode])
										,[Series] = ISNULL(@Series, [Series])
										,[BirthDay] = ISNULL(@BirthDay, [BirthDay])
										,[FirstName] = ISNULL(@FirstName, [Firstname])
										,[LastName] = ISNULL(@LastName, [LastName])
										WHERE [Id] = @PassportId

			SET @CountRow = @@ROWCOUNT
			COMMIT
			IF (@CountRow > 0)
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