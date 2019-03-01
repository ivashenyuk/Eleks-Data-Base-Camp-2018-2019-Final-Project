CREATE PROCEDURE [dbo].[MatchAdd]
	@HomeTeamId INT
	,@AwayTeamId INT
	,@ManagerId INT
	,@LocationId INT
	,@SportId INT
	,@TournamentId INT
	,@Date NVARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Matches]([HomeTeamId]
										,[AwayTeamId]
										,[ManagerId]
										,[LocationId]
										,[SportId]
										,[TournamentId]
										,[Date])
				VALUES (@HomeTeamId
						,@AwayTeamId
						,@ManagerId
						,@LocationId
						,@SportId
						,@TournamentId
						,CONVERT(DATETIME2, @Date))

			DECLARE @MatchId INT = SCOPE_IDENTITY()
			COMMIT;
			RETURN @MatchId
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN
				ROLLBACK
				;THROW
			END;
			RETURN -1
		END CATCH
END
