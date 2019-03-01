CREATE TABLE [dbo].[Users]
(
	[Id] INT NOT NULL CONSTRAINT PK_User_Id  PRIMARY KEY IDENTITY(1,1)
	,[PassportId] INT NOT NULL CONSTRAINT FK_Passport_Users_Passports FOREIGN KEY REFERENCES [dbo].[Passports]([Id])
	,[RoleId] INT NOT NULL CONSTRAINT FK_Role_Users_Roles FOREIGN KEY REFERENCES [dbo].[Roles]([Id])
	,[LocationId] INT NULL CONSTRAINT FK_Location_Users_Locations FOREIGN KEY REFERENCES [dbo].[Locations]([Id])
	,[BankCardId] INT NULL CONSTRAINT FK_Bank_Card_Users_BankCards FOREIGN KEY REFERENCES [dbo].[BankCards]([Id])
	,[PurseId] INT NOT NULL CONSTRAINT FK_Purse_Users_Purses FOREIGN KEY REFERENCES [dbo].[Purses]([Id])
	,[UserGroupId] INT NOT NULL CONSTRAINT FK_Purse_Users_UserGroups FOREIGN KEY REFERENCES [dbo].[UserGroups]([Id])
	,[Language] NVARCHAR(255) NOT NULL
	,[Email] NVARCHAR(100) NOT NULL
	,[Phone] NVARCHAR(15) NOT NULL
	,[HashPassword]  NVARCHAR(200) NOT NULL
	,[Age] INT NOT NULL CONSTRAINT CK_User_Age_Users CHECK([Age] >= 18)
	,[EmailIsConfirmed] BIT NOT NULL
	,[PhoneIsConfirmed] BIT NOT NULL
	,[IsConfirmedAdministrations] BIT NOT NULL
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Created_At_Users DEFAULT GETDATE()
)
