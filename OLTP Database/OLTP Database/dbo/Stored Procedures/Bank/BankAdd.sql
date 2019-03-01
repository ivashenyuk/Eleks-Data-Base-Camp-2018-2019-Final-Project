CREATE PROCEDURE [dbo].[BankAdd]
	@Name NVARCHAR(255)
	,@MinMoneyToWithdraw MONEY
	,@Commission FLOAT
	,@TimeOfProcessing BIGINT
	,@Description NVARCHAR(500) = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Banks]([Name]
									, [MinMoneyToWithdraw]
									, [Commission]
									, [TimeOfProcessing]
									, [Description])
									VALUES (@Name
											,@MinMoneyToWithdraw
											,@Commission
											,@TimeOfProcessing
											,@Description
											)
			DECLARE @BankId INT = SCOPE_IDENTITY()
			COMMIT;
			RETURN @BankId
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
