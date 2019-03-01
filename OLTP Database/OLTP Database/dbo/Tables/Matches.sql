CREATE TABLE [dbo].[Matches]
(
	[Id] INT NOT NULL CONSTRAINT PK_Matche_Id PRIMARY KEY IDENTITY(1,1)
	,[IdFromCsvFile] INT NULL
	,[IdFromJsonFile] INT NULL
	,[HomeTeamId] INT NOT NULL CONSTRAINT FK_Home_Team_Id_Matches_Teams FOREIGN KEY REFERENCES [dbo].[Teams]([Id])
	,[AwayTeamId] INT NOT NULL CONSTRAINT FK_Away_Team_Id_Matches_Teams FOREIGN KEY REFERENCES [dbo].[Teams]([Id])
	,[ManagerId] INT NULL CONSTRAINT FK_Manager_Id_Matches_Users FOREIGN KEY REFERENCES [dbo].[Users]([Id])
	,[LocationId] INT NOT NULL CONSTRAINT FK_Location_Id_Matches_Locations FOREIGN KEY REFERENCES [dbo].[Locations]([Id])
	,[SportId] INT NOT NULL CONSTRAINT FK_Sport_Id_Matches_Sports FOREIGN KEY REFERENCES [dbo].[Sports]([Id])
	,[TournamentId] INT NULL CONSTRAINT FK_Tournament_Id_Matches_Tournaments FOREIGN KEY REFERENCES [dbo].[Tournaments]([Id])
	,[IsStarted] BIT NOT NULL CONSTRAINT DF_Is_Started_Matches DEFAULT 0
	,[IsEnded] BIT NOT NULL CONSTRAINT DF_Is_Ended_Matches DEFAULT 0
	,[ScoreHomeTeam] INT NOT NULL CONSTRAINT DF_ScoreHomeTeam_Matches DEFAULT 0
	,[ScoreAwayTeam] INT NOT NULL CONSTRAINT DF_ScoreAwayTeam_Matches DEFAULT 0
	,[Date] DATETIME2 NOT NULL
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Created_At_Matches DEFAULT GETDATE()
)