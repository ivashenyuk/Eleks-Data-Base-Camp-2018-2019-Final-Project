CREATE PROCEDURE [dbo].[TeamAdd]
	@ClubId INT
	,@TeamManagerId INT
	,@Name NVARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Teams]([ClubId], [TeamManagerId], [Name]) 
				VALUES (NULLIF(@ClubId, 0), NULLIF(@TeamManagerId, 0), @Name)
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
