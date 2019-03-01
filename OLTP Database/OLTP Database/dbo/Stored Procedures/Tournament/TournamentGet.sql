CREATE PROCEDURE [dbo].[TournamentGet]
	@TournamentId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@TournamentId IS NULL)
			BEGIN
				SELECT * FROM [dbo].[Tournaments]
			END
			ELSE
			BEGIN
				SELECT TOP 1 * FROM [dbo].[Tournaments] WHERE [Id] = @TournamentId
			END
			COMMIT
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN 
				ROLLBACK
				;THROW
			END
			RETURN NULL
		END CATCH

END