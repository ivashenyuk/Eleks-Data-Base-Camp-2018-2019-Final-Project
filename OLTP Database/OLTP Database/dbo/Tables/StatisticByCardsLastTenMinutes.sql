﻿CREATE TABLE [dbo].[StatisticByCards]
(
	--[Id] INT NOT NULL  CONSTRAINT PK_StatisticByCards_Id PRIMARY KEY IDENTITY(1, 1)
	[ConnectorKey] NVARCHAR(300) NOT NULL CONSTRAINT PK_StatisticByCards_Id PRIMARY KEY
	,[CardType] NVARCHAR(255) NOT NULL
	,[NamePlayer] NVARCHAR(300) NOT NULL
	,[NameTeam] NVARCHAR(300) NOT NULL
	,[Count] INT NOT NULL CONSTRAINT DF_Count_StatisticByCards DEFAULT 0
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Create_At_StatisticByCards DEFAULT GETDATE()
)
