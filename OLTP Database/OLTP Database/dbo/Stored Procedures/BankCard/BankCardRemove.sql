﻿CREATE PROCEDURE [dbo].[BankCardRemove]
	@TeamId INT
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			DELETE FROM [dbo].[Teams] WHERE [Id] = @TeamId
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
