CREATE PROCEDURE [dbo].[PassportGet]
	@PassportId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@PassportId IS NULL)
			BEGIN
				SELECT * FROM [dbo].[Passports]
			END
			ELSE
			BEGIN
				SELECT TOP 1 * FROM [dbo].[Passports] WHERE [Id] = @PassportId
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
