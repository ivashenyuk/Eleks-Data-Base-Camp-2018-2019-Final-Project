CREATE TABLE [dbo].[Bets]
(
	[Id] INT NOT NULL CONSTRAINT PK_Bet_Id PRIMARY KEY IDENTITY(1,1)
	,[MatchId] INT NOT NULL CONSTRAINT FK_Match_Bets_Events FOREIGN KEY REFERENCES [dbo].[Events]([Id])
	,[UserId]  INT NOT NULL CONSTRAINT FK_User_Bets_Users FOREIGN KEY REFERENCES [dbo].[Users]([Id])
	,[ScoreHomeTeam] INT NULL CONSTRAINT DF_Score_Home_Team_Bets DEFAULT 0
	,[ScoreAwayTeam] INT NULL CONSTRAINT DF_Score_Away_Team_Bets DEFAULT 0
	,[ChanceToWin] FLOAT NOT NULL
	,[PutMoney] MONEY NOT NULL CONSTRAINT DF_Put_Money_Bets DEFAULT (0.00)
	,[Tax] FLOAT NOT NULL
	,[CommissionOfSite] FLOAT NOT NULL
	,[Prize] MONEY NOT NULL
	,[Date] DATETIME2 NOT NULL
	,[CoefficientHomeWin] FLOAT NOT NULL
	,[CoefficientAwayWin] FLOAT NOT NULL
	,[CoefficientDraw] FLOAT NOT NULL
	,[CoefficientHomeWinOrAwayWin] FLOAT NOT NULL
	,[CoefficientAwayWinOrDraw] FLOAT NOT NULL
	,[CoefficientHomeWinOrDraw] FLOAT NOT NULL
	,[HandicapValue] FLOAT NOT NULL
	,[CoefficientHandicap] FLOAT NOT NULL
	,[Over] FLOAT NOT NULL
	,[Under] FLOAT NOT NULL
	,[Total] FLOAT NOT NULL
	,[MaxAmountPutMoney] MONEY NOT NULL
	,[ResultIsWin] BIT NULL
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Created_At_Bets DEFAULT GETDATE()
)
