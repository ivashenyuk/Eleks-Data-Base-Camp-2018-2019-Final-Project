CREATE PROCEDURE [dbo].[TournamentAdd]
	@Name NVARCHAR(255)
	,@OrganizationName  NVARCHAR(255)
	,@Description NVARCHAR(800)
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Tournaments]([Name], [OrganizationName], [Description])
				VALUES(@Name, @OrganizationName, @Description)
			DECLARE @TeamId INT = SCOPE_IDENTITY()
			COMMIT;
			RETURN @TeamId
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
