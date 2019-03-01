CREATE PROCEDURE [dbo].[SportAdd]
	@Name NVARCHAR(255)
	,@Description NVARCHAR(800) = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Sports]([Name], [Description]) 
				VALUES (@Name, @Description)

			DECLARE @SportId INT = SCOPE_IDENTITY()
			COMMIT;
			RETURN @SportId
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
