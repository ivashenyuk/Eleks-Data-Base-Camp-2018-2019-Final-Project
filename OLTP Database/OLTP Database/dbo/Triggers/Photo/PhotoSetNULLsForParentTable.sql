CREATE TRIGGER [PhotoSetNULLsForParentTable]
ON [dbo].[Photos]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Passports]
		SET [PhotoIDOwnerId] = NULL
			,[PhotoOwnerWithPassportId] = NULL
			,[PhotoPage1Id] = NULL
			,[PhotoPage2Id] = NULL
			,[PhotoRegistrationId] = NULL
			FROM [dbo].[Passports] pwd
				INNER JOIN deleted d ON pwd.PhotoPage1Id = d.Id OR
										pwd.PhotoPage2Id = d.Id OR
										pwd.PhotoIDOwnerId = d.Id OR
										pwd.PhotoOwnerWithPassportId = d.Id OR
										pwd.PhotoRegistrationId = d.Id
 
	DELETE FROM [dbo].[Photos] WHERE [Id] IN (SELECT [Id] FROM deleted)
END