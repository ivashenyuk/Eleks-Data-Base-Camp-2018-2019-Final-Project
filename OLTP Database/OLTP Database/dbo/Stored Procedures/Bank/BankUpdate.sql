CREATE PROCEDURE [dbo].[BankUpdate]
	 @BankId INT
	,@Name NVARCHAR(255) = NULL
	,@MinMoneyToWithdraw MONEY = NULL
	,@Commission FLOAT = NULL
	,@TimeOfProcessing BIGINT = NULL
	,@Description NVARCHAR(500) = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
	DECLARE @CountRow INT = 0
	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Banks] SET [Name] = ISNULL(@Name, [Name])
									,[MinMoneyToWithdraw] = ISNULL(NULLIF(@MinMoneyToWithdraw, 0.00), [MinMoneyToWithdraw])
									,[Commission] = ISNULL(NULLIF(@Commission, 0), [Commission])
									,[TimeOfProcessing] = ISNULL(NULLIF(@TimeOfProcessing, 0), [TimeOfProcessing])
									,[Description] = ISNULL(@Description, [Description])
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