CREATE PROCEDURE [dbo].[MatchGet]
	@MatchId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@MatchId IS NULL)
			BEGIN
				SELECT [Id]
					  ,[HomeTeamId]
					  ,[AwayTeamId]
					  ,[ManagerId]
					  ,[LocationId]
					  ,[SportId]
					  ,[TournamentId]
					  ,[IsStarted]
					  ,[ScoreHomeTeam]
					  ,[ScoreAwayTeam]
					  ,[Date]
					  ,[CreatedAt] FROM [dbo].[Matches]
			END
			ELSE
			BEGIN
				SELECT TOP 1 [Id]
							  ,[HomeTeamId]
							  ,[AwayTeamId]
							  ,[ManagerId]
							  ,[LocationId]
							  ,[SportId]
							  ,[TournamentId]
							  ,[IsStarted]
							  ,[ScoreHomeTeam]
							  ,[ScoreAwayTeam]
							  ,[Date]
							  ,[CreatedAt] FROM [dbo].[Matches] WHERE [Id] = @MatchId
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
