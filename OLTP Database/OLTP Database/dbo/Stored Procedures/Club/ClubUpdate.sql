CREATE PROCEDURE [dbo].[ClubUpdate]
	@ClubId INT
	,@Name NVARCHAR(255) = NULL
	,@ClubManagerId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Clubs] SET [Name] = ISNULL(@Name, [Name])
									,[ClubManagerId] = ISNULL(NULLIF(@ClubManagerId, 0), [ClubManagerId])
									WHERE [Id] = @ClubId
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
