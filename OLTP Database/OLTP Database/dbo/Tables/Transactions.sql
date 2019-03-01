CREATE TABLE [dbo].[Transactions]
(
	[Id] INT NOT NULL CONSTRAINT PK_Transaction_Id PRIMARY KEY IDENTITY(1,1)
	,[UserId] INT NOT NULL CONSTRAINT FK_User_Id_Transactions_Users FOREIGN KEY REFERENCES [dbo].[Users]([Id])
	,[BetId] INT NOT NULL CONSTRAINT FK_Bet_Id_Transactions_Bets FOREIGN KEY REFERENCES [dbo].[Bets]([Id])
	,[Amount] MONEY NOT NULL
	,[TransactionDate] DATETIME2 NOT NULL
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Created_At_Transactions DEFAULT GETDATE()
)
