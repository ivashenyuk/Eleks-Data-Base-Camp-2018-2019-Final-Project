CREATE PROCEDURE [dbo].[LocationAdd]
	@City NVARCHAR(500)
	,@State NVARCHAR(500)
	,@Country NVARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Locations]([City], [State], [Country]) 
				VALUES (@City, @State, @Country)
			DECLARE @LocationId INT = SCOPE_IDENTITY()
			COMMIT;
			RETURN @LocationId
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
