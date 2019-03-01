CREATE PROCEDURE [dbo].[BankCardAdd]
	@UserId INT
	,@BankId INT
	,@CardNumber VARCHAR(16)
	,@ExpiryDateCard DATE
	,@DigitsOnBackOfCard TINYINT
	,@IsConfirmedCard BIT
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[BankCards]([BankId] , [CardNumber], [ExpiryDateCard], [DigitsOnBackOfCard])
				VALUES (@BankId, @CardNumber, @ExpiryDateCard, @DigitsOnBackOfCard)
			DECLARE @BankCardId INT = SCOPE_IDENTITY()
			UPDATE [dbo].[Users] SET [BankCardId] = @BankCardId WHERE [Id] = @UserId
			COMMIT;
			RETURN @BankCardId
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
