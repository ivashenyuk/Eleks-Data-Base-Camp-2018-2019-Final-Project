CREATE TABLE [dbo].[Events]
(
	[Id] INT NOT NULL CONSTRAINT PK_Event_Id PRIMARY KEY IDENTITY(1,1)
	,[MatchId] INT NOT NULL CONSTRAINT FK_Match_Id_Events_Matches FOREIGN KEY REFERENCES [dbo].[Matches]([Id])
	,[DescriptionEvent] NVARCHAR(500) NULL
	,[ScoreHomeTeam] INT NOT NULL
	,[ScoreAwayTeam] INT NOT NULL
	,[TimeEvent] TIME NULL
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Created_At_Events DEFAULT GETDATE()
)
