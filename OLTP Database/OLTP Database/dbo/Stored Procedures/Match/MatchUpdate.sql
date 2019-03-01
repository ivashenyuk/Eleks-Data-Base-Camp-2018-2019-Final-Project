CREATE PROCEDURE [dbo].[MatchUpdate]
	@MatchId INT
	,@HomeTeamId INT = NULL
	,@AwayTeamId INT = NULL
	,@ManagerId INT = NULL
	,@LocationId INT = NULL
	,@SportId INT = NULL
	,@TournamentId INT = NULL
	,@Date DATE = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Matches] SET [HomeTeamId] = ISNULL(NULLIF(@HomeTeamId, 0), [HomeTeamId])
									,[AwayTeamId] = ISNULL(NULLIF(@AwayTeamId, 0), [AwayTeamId])
									,[ManagerId] = ISNULL(NULLIF(@ManagerId, 0), [ManagerId])
									,[LocationId] = ISNULL(NULLIF(@LocationId, 0), [LocationId])
									,[SportId] = ISNULL(NULLIF(@SportId, 0), [SportId])
									,[TournamentId] = ISNULL(NULLIF(@TournamentId, 0), [TournamentId])
									,[Date] = ISNULL(@Date, [Date])
									WHERE [Id] = @MatchId

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