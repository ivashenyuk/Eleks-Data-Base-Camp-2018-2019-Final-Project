CREATE PROCEDURE [dbo].[BankCardUpdate]
	@Id INT
	,@BankId INT
	,@CardNumber VARCHAR(16)
	,@ExpiryDateCard DATE
	,@DigitsOnBackOfCard TINYINT
	,@IsConfirmedCard BIT
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[BankCards] SET [BankId] = ISNULL(NULLIF(@BankId, 0), [BankId])
									,[CardNumber] = ISNULL(@CardNumber, [CardNumber])
									,[ExpiryDateCard] = ISNULL(@ExpiryDateCard, [ExpiryDateCard])
									,[DigitsOnBackOfCard] = ISNULL(@DigitsOnBackOfCard, [DigitsOnBackOfCard])
									WHERE [Id] = @BankId

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