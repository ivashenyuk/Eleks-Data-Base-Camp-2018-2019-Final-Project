﻿CREATE PROCEDURE [dbo].[PhotoGet]
	@PhotoId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@PhotoId IS NULL)
			BEGIN
				SELECT * FROM [dbo].[Photos]
			END
			ELSE
			BEGIN
				SELECT TOP 1 * FROM [dbo].[Photos] WHERE [Id] = @PhotoId
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