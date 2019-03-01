CREATE PROCEDURE [dbo].[RoleUpdate]
	 @RoleId INT
	,@Role NVARCHAR(50)
	,@Description NVARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Roles] 
				SET [Role] = ISNULL(@Role, [Role])
									,[Description] = ISNULL(@Description, [Description])
									WHERE [Id] = @RoleId
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
