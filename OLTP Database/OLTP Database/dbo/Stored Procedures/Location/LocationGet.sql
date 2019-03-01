CREATE PROCEDURE [dbo].[LocationGet]
	@LocationId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@LocationId IS NULL)
			BEGIN
				SELECT * FROM [dbo].[Locations]
			END
			ELSE
			BEGIN
				SELECT TOP 1 * FROM [dbo].[Locations] WHERE [Id] = @LocationId
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
