CREATE TABLE [dbo].[Passports]
(
	[Id] INT NOT NULL CONSTRAINT PK_Passport_Id PRIMARY KEY IDENTITY(1,1)
	,[PassportCode] VARCHAR(15) NULL
	,[Series] NVARCHAR(5) NULL
	,[BirthDay] DATE NULL
	,[FirstName] NVARCHAR(255) NOT NULL
	,[LastName] NVARCHAR(255) NOT NULL
	,[PhotoPage1Id] INT NULL CONSTRAINT FK_Photo_Page_1_Passports_Photos FOREIGN KEY REFERENCES [dbo].[Photos]([Id])
	,[PhotoPage2Id] INT NULL CONSTRAINT FK_Photo_Page_2_Passports_Photos FOREIGN KEY REFERENCES [dbo].[Photos]([Id])
	,[PhotoRegistrationId] INT NULL CONSTRAINT FK_Photo_Page_Registration_Passports_Photos FOREIGN KEY REFERENCES [dbo].[Photos]([Id])
	,[PhotoIDOwnerId] INT NULL CONSTRAINT FK_Photo_ID_Owner_Passports_Photos FOREIGN KEY REFERENCES [dbo].[Photos]([Id])
	,[PhotoOwnerWithPassportId] INT NULL CONSTRAINT FK_Photo_Owner_With_Passport_Passports_Photos FOREIGN KEY REFERENCES [dbo].[Photos]([Id])
	,[CreatedAt] DATETIME2 NOT NULL CONSTRAINT DF_Created_At_Passports DEFAULT GETDATE()
)
