CREATE PROCEDURE [dbo].[LocationUpdate]
	 @LocationId INT
	,@City NVARCHAR(500) = NULL
	,@State NVARCHAR(500) = NULL
	,@Country NVARCHAR(500) = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Locations] SET [City] = ISNULL(@City, [City])
									,[State] = ISNULL(@State, [State])
									,[Country] = ISNULL(@Country, [Country])
									WHERE [Id] = @LocationId
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
