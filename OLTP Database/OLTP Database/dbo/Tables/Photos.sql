﻿CREATE TABLE [dbo].[Photos]
(
	[Id] INT NOT NULL CONSTRAINT PK_Photo_Id PRIMARY KEY IDENTITY(1,1)
	,[DefaultFileName] NVARCHAR(255) NOT NULL
	,[Path] NVARCHAR(2000) NOT NULL
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Created_At_Photos DEFAULT GETDATE()
)
