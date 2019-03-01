CREATE PROCEDURE [dbo].[PassportAdd]
	@PassportCode VARCHAR(15) = NULL
	,@Series  NVARCHAR(5) = NULL
	,@BirthDay DATE
	,@FirstName NVARCHAR(255)
	,@LastName NVARCHAR(255)
	,@PhotoRegistrationId INT = NULL
	,@PhotoOwnerWithPassportId INT = NULL
	,@PhotoIDOwnerId INT = NULL
	,@PhotoPage2Id INT = NULL
	,@PhotoPage1Id INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Passports]([PassportCode]
										, [Series]
										, [BirthDay]
										, [FirstName]
										, [LastName]
										, [PhotoRegistrationId]
										, [PhotoOwnerWithPassportId]
										, [PhotoIDOwnerId]
										, [PhotoPage2Id]
										, [PhotoPage1Id])
				VALUES (
						@PassportCode
						,@Series
						,@BirthDay
						,@FirstName
						,@LastName
						,@PhotoRegistrationId
						,@PhotoOwnerWithPassportId
						,@PhotoIDOwnerId
						,@PhotoPage2Id
						,@PhotoPage1Id)
			DECLARE @PassportId INT = SCOPE_IDENTITY()
			COMMIT;
			RETURN @PassportId
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
