CREATE PROCEDURE [dbo].[RoleAdd]
	@Role NVARCHAR(50)
	,@Description NVARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Roles]([Role], [Description]) 
				VALUES (@Role, @Description)
			DECLARE @RoleId INT = SCOPE_IDENTITY()
			COMMIT;
			RETURN @RoleId
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
