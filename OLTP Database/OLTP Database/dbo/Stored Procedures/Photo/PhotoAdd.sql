CREATE PROCEDURE [dbo].[PhotoAdd]
	@Photo_Name NVARCHAR(400)
	,@Photo_Path NVARCHAR(2000)
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Photos]([DefaultFileName], [Path]) 
				VALUES (@Photo_Name, @Photo_Path)
			DECLARE @PhotoId INT = SCOPE_IDENTITY()
			COMMIT;
			RETURN @PhotoId
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
