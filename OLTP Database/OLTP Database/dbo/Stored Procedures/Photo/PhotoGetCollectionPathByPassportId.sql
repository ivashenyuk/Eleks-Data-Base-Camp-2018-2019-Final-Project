CREATE PROCEDURE [dbo].[PhotoGetCollectionPathByPassportId]
	@PassportId INT
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			DECLARE @PassportPhotosId TABLE (
				[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1)
				,[PhotoId] INT NULL
			)

			INSERT INTO @PassportPhotosId([PhotoId]) 
				SELECT [PhotoId]
					FROM ( SELECT TOP 1 [passport].[Id]
								,[passport].[PhotoPage1Id]
								,[passport].[PhotoPage2Id]
								,[passport].[PhotoIDOwnerId]
								,[passport].[PhotoOwnerWithPassportId]
								,[passport].[PhotoRegistrationId] 
								FROM [dbo].[Passports] AS [passport]
								WHERE [passport].[Id] = @PassportId
							) AS passPhotos
							UNPIVOT (
								PhotoId FOR TempPhotoName
									IN([PhotoPage1Id], [PhotoPage2Id], [PhotoIDOwnerId]
										,[PhotoOwnerWithPassportId], [PhotoRegistrationId] )

							) AS [unpivot]

			-- returned the path to the files
			SELECT [Path] FROM [dbo].[Photos] WHERE [Id] IN (SELECT [PhotoId] FROM @PassportPhotosId)
			
			COMMIT
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN 
				ROLLBACK
				;THROW
			END
			RETURN NULL
		END CATCH

END
