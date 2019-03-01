﻿CREATE PROCEDURE [dbo].[RoleGet]
	@RoleId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@RoleId IS NULL)
			BEGIN
				SELECT * FROM [dbo].[Roles]
			END
			ELSE
			BEGIN
				SELECT TOP 1 * FROM [dbo].[Roles] WHERE [Id] = @RoleId
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
