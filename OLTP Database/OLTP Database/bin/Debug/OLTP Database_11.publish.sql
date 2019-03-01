﻿/*
Deployment script for BookmakerOLTP

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BookmakerOLTP"
:setvar DefaultFilePrefix "BookmakerOLTP"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column PurseId on table [dbo].[Users] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column RoleId on table [dbo].[Users] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Users])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping [dbo].[FK_Purse_Users_Purses]...';


GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_Purse_Users_Purses];


GO
PRINT N'Dropping [dbo].[FK_Role_Users_Roles]...';


GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_Role_Users_Roles];


GO
PRINT N'Altering [dbo].[Users]...';


GO
ALTER TABLE [dbo].[Users] ALTER COLUMN [PurseId] INT NOT NULL;

ALTER TABLE [dbo].[Users] ALTER COLUMN [RoleId] INT NOT NULL;


GO
PRINT N'Creating [dbo].[FK_Purse_Users_Purses]...';


GO
ALTER TABLE [dbo].[Users] WITH NOCHECK
    ADD CONSTRAINT [FK_Purse_Users_Purses] FOREIGN KEY ([PurseId]) REFERENCES [dbo].[Purses] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Role_Users_Roles]...';


GO
ALTER TABLE [dbo].[Users] WITH NOCHECK
    ADD CONSTRAINT [FK_Role_Users_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([Id]);


GO
PRINT N'Altering [dbo].[UserRegistration]...';


GO
ALTER PROCEDURE [dbo].[UserRegistration]
	@FirstName NVARCHAR(255)
	,@LastName NVARCHAR(255)
	,@BirthDay DATE
	,@Email NVARCHAR(100)
	,@Phone NVARCHAR(15)
	,@HashPassword  NVARCHAR(200)
	,@EmailIsConfimed BIT = 0
	,@PhoneIsConfimed BIT = 0
	,@IsConfimedAdministrations BIT = 0
	,@Language NVARCHAR(255) = N'English'
	,@Role INT = 1
	,@Currency VARCHAR(3) = 'USD'
AS
BEGIN
	DECLARE @UserId INT = -1
	BEGIN TRAN
		BEGIN TRY
			-- Creating user passport
			INSERT INTO [dbo].[Passports]([FirstName], [LastName], [BirthDay]) VALUES (@FirstName, @LastName, @BirthDay)
			DECLARE @PassportId INT = SCOPE_IDENTITY()
					,@Age INT = DATEDIFF ( YEAR , @BirthDay, GETDATE()) - (CASE WHEN GETDATE() < DATEADD(yyyy,DATEDIFF(yyyy,@BirthDay,GETDATE()),@BirthDay) THEN 1 ELSE 0 END)
			
			-- Creating user purse
			INSERT INTO [dbo].[Purses]([Currency]) VALUES (@Currency)
			DECLARE @PurseId INT = SCOPE_IDENTITY()

			-- Creatin user account
			INSERT INTO [dbo].[Users]( [PassportId]
									, [PurseId]
									, [RoleId]
									, [Email]
									, [Phone]
									, [HashPassword]
									, [Language]
									, [Age]
									, [EmailIsConfirmed]
									, [PhoneIsConfirmed]
									, [IsConfirmedAdministrations]) 
									VALUES (@PassportId
											, @PurseId
											, 1
											, @Email
											, @Phone
											, @HashPassword
											, @Language
											, @Age
											, @EmailIsConfimed
											, @PhoneIsConfimed
											, @IsConfimedAdministrations)

			SET @UserId = SCOPE_IDENTITY()

			COMMIT
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN
				ROLLBACK;
				THROW;

			END
				
		END CATCH

	

	RETURN @UserId
END
GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Users] WITH CHECK CHECK CONSTRAINT [FK_Purse_Users_Purses];

ALTER TABLE [dbo].[Users] WITH CHECK CHECK CONSTRAINT [FK_Role_Users_Roles];


GO
PRINT N'Update complete.';


GO
