CREATE PROCEDURE [dbo].[PhotoRemove]
	@PhotoId INT
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			UPDATE [dbo].[Passports] SET [PhotoIDOwnerId] = ISNULL(NULLIF([PhotoIDOwnerId], @PhotoId), [PhotoIDOwnerId])
										,[PhotoOwnerWithPassportId] = ISNULL(NULLIF([PhotoOwnerWithPassportId], @PhotoId), [PhotoOwnerWithPassportId])
										,[PhotoPage1Id] = ISNULL(NULLIF([PhotoPage1Id], @PhotoId), [PhotoPage1Id])
										,[PhotoPage2Id] = ISNULL(NULLIF([PhotoPage2Id], @PhotoId), [PhotoPage2Id])
										,[PhotoRegistrationId] = ISNULL(NULLIF([PhotoRegistrationId], @PhotoId), [PhotoRegistrationId])

			DELETE FROM [dbo].[Photos] WHERE [Id] = @PhotoId
			COMMIT
			RETURN 1
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
