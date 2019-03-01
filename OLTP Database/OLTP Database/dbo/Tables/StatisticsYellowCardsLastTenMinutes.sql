CREATE TABLE [dbo].[StatisticsByCardsLastTenMinutes]
(
	[Id] INT NOT NULL CONSTRAINT PK_StatisticsByCardsLastTenMinutes_Id PRIMARY KEY IDENTITY(1, 1)
	,[CardType] NVARCHAR(255) NOT NULL
	,[NamePlayer] NVARCHAR(300) NOT NULL
	,[NameTeam] NVARCHAR(300) NOT NULL
	,[Time] TIME NOT NULL
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Create_At_StatisticsByCardsLastTenMinutes DEFAULT GETDATE()
)
