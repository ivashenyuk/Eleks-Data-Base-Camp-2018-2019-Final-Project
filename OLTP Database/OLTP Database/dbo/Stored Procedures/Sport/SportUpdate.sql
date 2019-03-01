CREATE PROCEDURE [dbo].[SportUpdate]
	@SportId INT
	,@Name NVARCHAR(255) = NULL
	,@Decription NVARCHAR(800) = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Sports] SET [Name] = ISNULL(@Name, [Name])
									 ,[Description] = ISNULL(@Decription, [Description])
									WHERE [Id] = @SportId
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