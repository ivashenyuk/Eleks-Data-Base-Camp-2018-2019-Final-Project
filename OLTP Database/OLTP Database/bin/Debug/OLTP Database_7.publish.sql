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
The column [dbo].[BankCards].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[BankCards].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[BankCards])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Banks].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Banks].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Banks])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Bets].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Bets].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Bets])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Clubs].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Clubs].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Clubs])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Events].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Events].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Events])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Locations].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Locations].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Locations])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Matches].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Matches].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Matches])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Organizations].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Organizations].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Organizations])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Passports].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Passports].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Passports])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Photos].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Photos].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Photos])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Purses].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Purses].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Purses])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Roles].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Roles].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Roles])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Sports].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Sports].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Sports])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Teams].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Teams].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Teams])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Tournaments].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Tournaments].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Tournaments])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Transactions].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Transactions].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Transactions])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Users].[LastEditedById] is being dropped, data loss could occur.

The column [dbo].[Users].[UpdatedAt] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Users])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_BankCards_Users]...';


GO
ALTER TABLE [dbo].[BankCards] DROP CONSTRAINT [FK_Last_Edited_By_BankCards_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Banks_Users]...';


GO
ALTER TABLE [dbo].[Banks] DROP CONSTRAINT [FK_Last_Edited_By_Banks_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Bets_Users]...';


GO
ALTER TABLE [dbo].[Bets] DROP CONSTRAINT [FK_Last_Edited_By_Bets_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Clubs_Users]...';


GO
ALTER TABLE [dbo].[Clubs] DROP CONSTRAINT [FK_Last_Edited_By_Clubs_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Events_Users]...';


GO
ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_Last_Edited_By_Events_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Locations_Users]...';


GO
ALTER TABLE [dbo].[Locations] DROP CONSTRAINT [FK_Last_Edited_By_Locations_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Matches_Users]...';


GO
ALTER TABLE [dbo].[Matches] DROP CONSTRAINT [FK_Last_Edited_By_Matches_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Organizations_Users]...';


GO
ALTER TABLE [dbo].[Organizations] DROP CONSTRAINT [FK_Last_Edited_By_Organizations_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Passports_Users]...';


GO
ALTER TABLE [dbo].[Passports] DROP CONSTRAINT [FK_Last_Edited_By_Passports_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Photos_Users]...';


GO
ALTER TABLE [dbo].[Photos] DROP CONSTRAINT [FK_Last_Edited_By_Photos_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Purses_Users]...';


GO
ALTER TABLE [dbo].[Purses] DROP CONSTRAINT [FK_Last_Edited_By_Purses_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Roles_Users]...';


GO
ALTER TABLE [dbo].[Roles] DROP CONSTRAINT [FK_Last_Edited_By_Roles_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Sports_Users]...';


GO
ALTER TABLE [dbo].[Sports] DROP CONSTRAINT [FK_Last_Edited_By_Sports_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Teams_Users]...';


GO
ALTER TABLE [dbo].[Teams] DROP CONSTRAINT [FK_Last_Edited_By_Teams_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Tournaments_Users]...';


GO
ALTER TABLE [dbo].[Tournaments] DROP CONSTRAINT [FK_Last_Edited_By_Tournaments_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Transactions_Users]...';


GO
ALTER TABLE [dbo].[Transactions] DROP CONSTRAINT [FK_Last_Edited_By_Transactions_Users];


GO
PRINT N'Dropping [dbo].[FK_Last_Edited_By_Users_Users]...';


GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_Last_Edited_By_Users_Users];


GO
PRINT N'Altering [dbo].[BankCards]...';


GO
ALTER TABLE [dbo].[BankCards] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Banks]...';


GO
ALTER TABLE [dbo].[Banks] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Bets]...';


GO
ALTER TABLE [dbo].[Bets] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Clubs]...';


GO
ALTER TABLE [dbo].[Clubs] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Events]...';


GO
ALTER TABLE [dbo].[Events] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Locations]...';


GO
ALTER TABLE [dbo].[Locations] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Matches]...';


GO
ALTER TABLE [dbo].[Matches] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Organizations]...';


GO
ALTER TABLE [dbo].[Organizations] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Passports]...';


GO
ALTER TABLE [dbo].[Passports] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Photos]...';


GO
ALTER TABLE [dbo].[Photos] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Purses]...';


GO
ALTER TABLE [dbo].[Purses] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Roles]...';


GO
ALTER TABLE [dbo].[Roles] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Sports]...';


GO
ALTER TABLE [dbo].[Sports] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Teams]...';


GO
ALTER TABLE [dbo].[Teams] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Transactions]...';


GO
ALTER TABLE [dbo].[Transactions] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Altering [dbo].[Users]...';


GO
ALTER TABLE [dbo].[Users] DROP COLUMN [LastEditedById], COLUMN [UpdatedAt];


GO
PRINT N'Creating [dbo].[UserRegistration]...';


GO
CREATE PROCEDURE [dbo].[UserRegistration]
	@FirstName NVARCHAR(255)
	,@LastName NVARCHAR(255)
	,@BirthDay DATE
	,@Email NVARCHAR(100)
	,@Phone NVARCHAR(15)
	,@HashPassword  NVARCHAR(200)
	,@EmailIsConfimed BIT = 0
	,@PhoneIsConfimed BIT = 0
	,@IsConfimedAdministrations BIT = 0
	
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Passports]([FirstName], [LastName], [BirthDay]) VALUES (@FirstName, @LastName, @BirthDay)


			COMMIT
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN
				ROLLBACK;
				THROW;

			END
				
		END CATCH

	

	RETURN 1
END
GO
PRINT N'Update complete.';


GO
