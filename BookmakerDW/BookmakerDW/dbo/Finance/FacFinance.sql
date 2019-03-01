CREATE TABLE [dbo].[FactFinance]
(
	[Id] INT NOT NULL CONSTRAINT PK_Bet_Id PRIMARY KEY IDENTITY(1,1)
	,[MatchId] INT NOT NULL CONSTRAINT FK_Match_FactFinance_DimMatch FOREIGN KEY REFERENCES [dbo].[DimMatch]([Id])
	,[UserId]  INT NOT NULL CONSTRAINT FK_User_FactFinance_DimUser FOREIGN KEY REFERENCES [dbo].[DimUser]([Id])
	,[DateId] INT NOT NULL CONSTRAINT FK_Date_FactFinance_DimDate FOREIGN KEY REFERENCES [dbo].[DimDate]([Id])
	,[LocationId] INT NOT NULL CONSTRAINT FK_Location_FactFinance_DimLocation FOREIGN KEY REFERENCES [dbo].[DimLocation]([Id])
	,[TournamentId] INT NOT NULL CONSTRAINT FK_Tournament_FactFinance_DimTournament FOREIGN KEY REFERENCES [dbo].[DimTournament]([Id])
	,[SportId] INT NOT NULL CONSTRAINT FK_Sport_FactFinance_DimSport FOREIGN KEY REFERENCES [dbo].[DimSport]([Id])
	,[UserGroupId] INT NOT NULL CONSTRAINT FK_Sport_FactFinance_DimUserGroup FOREIGN KEY REFERENCES [dbo].[DimUserGroup]([Id])
	,[Tax] MONEY NOT NULL
	,[Profit] MONEY NOT NULL 
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Created_At_FactFinance DEFAULT GETDATE()
)
