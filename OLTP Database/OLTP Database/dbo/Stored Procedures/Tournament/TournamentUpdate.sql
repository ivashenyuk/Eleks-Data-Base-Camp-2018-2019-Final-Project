CREATE PROCEDURE [dbo].[TournamentUpdate]
	@TournamentId INT
	,@Name NVARCHAR(255) = NULL
	,@OrganizationName  NVARCHAR(255) = NULL
	,@Description NVARCHAR(800) = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Tournaments] SET [Name] = ISNULL(@Name, [Name])
									,[OrganizationName] = ISNULL(@OrganizationName, [OrganizationName])
									,[Description] = ISNULL(@Description, [Description])
									WHERE [Id] = @TournamentId
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