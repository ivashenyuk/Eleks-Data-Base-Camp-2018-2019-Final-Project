﻿CREATE TABLE [dbo].[Roles]
(
	[Id] INT NOT NULL CONSTRAINT PK_Role_Id PRIMARY KEY IDENTITY(1,1)
	,[Role] NVARCHAR(50) NOT NULL
	,[Description] NVARCHAR(500) NULL
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Created_At_Roles DEFAULT GETDATE()
)
