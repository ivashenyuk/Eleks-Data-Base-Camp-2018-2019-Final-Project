﻿CREATE PROCEDURE [dbo].[ClubAdd]
	@Name NVARCHAR(255)
	,@ClubManagerId INT
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Clubs]([Name], [ClubManagerId]) 
				VALUES (@Name, NULLIF(@ClubManagerId, 0))
			DECLARE @ClubId INT = SCOPE_IDENTITY()
			COMMIT;
			RETURN @ClubId
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