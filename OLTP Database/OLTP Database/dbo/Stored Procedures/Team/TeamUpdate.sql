CREATE PROCEDURE [dbo].[TeamUpdate]
	 @TeamId INT
	,@ClubId INT = NULL
	,@TeamManagerId INT = NULL
	,@Name NVARCHAR(255) = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Teams] SET [ClubId] = ISNULL(NULLIF(@ClubId, 0), [ClubId])
									,[TeamManagerId] = ISNULL(NULLIF(@TeamManagerId, 0), [TeamManagerId])
									,[Name] = ISNULL(@Name, [Name]) WHERE [Id] = @TeamId
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
