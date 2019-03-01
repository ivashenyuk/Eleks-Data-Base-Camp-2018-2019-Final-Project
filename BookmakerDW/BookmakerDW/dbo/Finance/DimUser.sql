CREATE TABLE [dbo].[DimUser]
(
	[Id] INT NOT NULL CONSTRAINT PK_User_Id PRIMARY KEY IDENTITY(1,1)
	,[PassportCode] VARCHAR(15) NULL
	,[Series] NVARCHAR(5) NULL
	,[BirthDay] DATE NULL
	,[FirstName] NVARCHAR(255) NOT NULL
	,[LastName] NVARCHAR(255) NOT NULL
	,[Language] NVARCHAR(255) NOT NULL
	,[Email] NVARCHAR(100) NOT NULL
	,[Phone] NVARCHAR(15) NOT NULL
	,[Age] INT NOT NULL CONSTRAINT CK_User_Age_DimUser CHECK([Age] >= 18)
	,[EmailIsConfirmed] BIT NOT NULL
	,[PhoneIsConfirmed] BIT NOT NULL
	,[IsConfirmedAdministrations] BIT NOT NULL
)
