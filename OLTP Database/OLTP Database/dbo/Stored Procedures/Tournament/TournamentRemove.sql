﻿CREATE PROCEDURE [dbo].[TournamentRemove]
	@TournamentId INT
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			DELETE FROM [dbo].[Tournaments] WHERE [Id] = @TournamentId
			COMMIT
			RETURN 1
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
