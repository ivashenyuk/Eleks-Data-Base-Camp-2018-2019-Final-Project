﻿CREATE PROCEDURE [dbo].[EventGet]
	@EventId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@EventId IS NULL)
			BEGIN
				SELECT * FROM [dbo].[Events]
			END
			ELSE
			BEGIN
				SELECT TOP 1 * FROM [dbo].[Events] WHERE [Id] = @EventId
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
