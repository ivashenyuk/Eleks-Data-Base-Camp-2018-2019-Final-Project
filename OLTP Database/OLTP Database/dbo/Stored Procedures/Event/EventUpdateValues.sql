CREATE PROCEDURE [dbo].[EventUpdateValues]
	@MatchId INT
	,@ScoreHomeTeam INT = NULL
	,@ScoreAwayTeam INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Matches] SET [ScoreAwayTeam] = ISNULL(@ScoreAwayTeam, [ScoreAwayTeam])
									,[ScoreHomeTeam] = ISNULL(@ScoreHomeTeam,  [ScoreHomeTeam])
									WHERE [Id] = @MatchId

			SET @CountRow = @@ROWCOUNT

			UPDATE [dbo].[Bets] SET [ResultIsWin] = 1
									WHERE [ScoreHomeTeam] >= @ScoreHomeTeam AND 
										[ScoreAwayTeam] >= @ScoreAwayTeam

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