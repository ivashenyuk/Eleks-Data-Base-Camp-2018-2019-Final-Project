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
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

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
PRINT N'Altering [dbo].[MatchGet]...';


GO
ALTER PROCEDURE [dbo].[MatchGet]
	@MatchId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@MatchId IS NULL)
			BEGIN
				SELECT [Id]
					  ,[HomeTeamId]
					  ,[AwayTeamId]
					  ,[ManagerId]
					  ,[LocationId]
					  ,[SportId]
					  ,[TournamentId]
					  ,[IsStarted]
					  ,[ScoreHomeTeam]
					  ,[ScoreAwayTeam]
					  ,[Date]
					  ,[CreatedAt] FROM [dbo].[Matches]
			END
			ELSE
			BEGIN
				SELECT TOP 1 [Id]
							  ,[HomeTeamId]
							  ,[AwayTeamId]
							  ,[ManagerId]
							  ,[LocationId]
							  ,[SportId]
							  ,[TournamentId]
							  ,[IsStarted]
							  ,[ScoreHomeTeam]
							  ,[ScoreAwayTeam]
							  ,[Date]
							  ,[CreatedAt] FROM [dbo].[Matches] WHERE [Id] = @MatchId
			END
			COMMIT
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN 
				ROLLBACK
				;THROW
			END
			RETURN NULL
		END CATCH

END
GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


INSERT INTO [dbo].[Roles]([Role], [Description])
	VALUES 
	(N'Super Admin', N'have all rights'),
	(N'User', N'simple user who can edit and view his personal data and make some bets on event or series of events.'),
	(N'Sport Manager', N'could edit information about specific sport and its events.'),
	(N'Club Manager', N'edit information about everything related to one club.'),
	(N'Team Manager', N'edit information about everything related to one team from the club.'),
	(N'Event Manager', N'edit information about everything related to some specific events.'),
	(N'Location Manager', N'edit information about physical or non-physical places where events could be held.'),
	(N'Customer Support', N'edit information subset about specific system users.'),
	(N'Financial Manager', N'edit (add/update/delete) financial transactions data.'),
	(N'Financial Analytic', N'view financial reports.')


EXEC [dbo].[UserRegistration] -- 1
	@FirstName = N'Yuriy'
	,@LastName = N'Ivashenyuk'
	,@BirthDay = '1999-01-03'
	,@Email = N'yura.ivash@gmail.com'
	,@Phone = '+380982391675'
	,@HashPassword = N'1qwerty1'
	,@EmailIsConfirmed = 1
	,@PhoneIsConfirmed = 1
	,@IsConfirmedAdministrations = 1
	,@Language = N'English, Ukrainian'
	,@Currency = 'USD'

EXEC [dbo].[UserRegistration] -- 2
	@FirstName = N'Earl'
	,@LastName = N'Daniels'
	,@BirthDay = '6/1/1972'
	,@Email = N'earl.daniels76@example.com'
	,@Phone = '(518)-117-1469'
	,@HashPassword = N'killer'
	,@EmailIsConfirmed = 1
	,@PhoneIsConfirmed = 1
	,@IsConfirmedAdministrations = 1
	,@Language = N'English'
	,@Currency = 'USD'

EXEC [dbo].[UserRegistration] -- 3
	@FirstName = N'Ted'
	,@LastName = N'Brewer'
	,@BirthDay = '3/3/1982'
	,@Email = N'ted.brewer74@example.com'
	,@Phone = '(124)-855-5250'
	,@HashPassword = N'1977'
	,@EmailIsConfirmed = 1
	,@PhoneIsConfirmed = 1
	,@IsConfirmedAdministrations = 1
	,@Language = N'English'
	,@Currency = 'USD'

EXEC [dbo].[UserRegistration] -- 4
	@FirstName = N'Constance'
	,@LastName = N'Castillo'
	,@BirthDay = '1/7/1971'
	,@Email = N'constance.castillo72@example.com'
	,@Phone = '(967)-974-7962'
	,@HashPassword = N'blackdog'
	,@EmailIsConfirmed = 1
	,@PhoneIsConfirmed = 1
	,@IsConfirmedAdministrations = 1
	,@Language = N'Indian, Сhinese'
	,@Currency = 'IRN'

EXEC [dbo].[UserRegistration] -- 5
	@FirstName = N'alexander'
	,@LastName = N'Mendoza'
	,@BirthDay = '12/4/1972'
	,@Email = N'alexander.mendoza45@example.com'
	,@Phone = '(552)-657-7892'
	,@HashPassword = N'kitty1'
	,@EmailIsConfirmed = 1
	,@PhoneIsConfirmed = 1
	,@IsConfirmedAdministrations = 1
	,@Language = N'English'
	,@Currency = 'USD'

EXEC [dbo].[UserRegistration] -- 6
	@FirstName = N'Myrtle'
	,@LastName = N'May'
	,@BirthDay = '12/1/1983'
	,@Email = N'myrtle.may63@example.com'
	,@Phone = '(849)-852-3399'
	,@HashPassword = N'johndeer'
	,@EmailIsConfirmed = 1
	,@PhoneIsConfirmed = 1
	,@IsConfirmedAdministrations = 1
	,@Language = N'English, Сhinese'
	,@Currency = 'USD'

EXEC [dbo].[UserRegistration] -- 7
	@FirstName = N'Nathan'
	,@LastName = N'Watson'
	,@BirthDay = '4/2/1974'
	,@Email = N'nathan.watson87@example.com'
	,@Phone = '(897)-697-4258'
	,@HashPassword = N'hotred'
	,@EmailIsConfirmed = 1
	,@PhoneIsConfirmed = 1
	,@IsConfirmedAdministrations = 1
	,@Language = N'English'
	,@Currency = 'USD'

EXEC [dbo].[UserRegistration] -- 8
	@FirstName = N'chester'
	,@LastName = N'Fleming'
	,@BirthDay = '2/3/1971'
	,@Email = N'chester.fleming35@example.com'
	,@Phone = '(454)-681-7158'
	,@HashPassword = N'prayers'
	,@EmailIsConfirmed = 1
	,@PhoneIsConfirmed = 1
	,@IsConfirmedAdministrations = 1
	,@Language = N'English'
	,@Currency = 'USD'

EXEC [dbo].[UserRegistration] -- 9
	@FirstName = N'Hunter'
	,@LastName = N'Harper'
	,@BirthDay = '3/6/1977'
	,@Email = N'hunter.harper97@example.com'
	,@Phone = '(873)-984-4849'
	,@HashPassword = N'1945'
	,@EmailIsConfirmed = 1
	,@PhoneIsConfirmed = 1
	,@IsConfirmedAdministrations = 1
	,@Language = N'English, Ukrainian, Indian'
	,@Currency = 'USD'

EXEC [dbo].[UserRegistration] -- 10
	@FirstName = N'Gene'
	,@LastName = N'Reynolds'
	,@BirthDay = '1/5/1976'
	,@Email = N'gene.reynolds47@example.com'
	,@Phone = '(260)-468-1545'
	,@HashPassword = N'turkey50'
	,@EmailIsConfirmed = 1
	,@PhoneIsConfirmed = 1
	,@IsConfirmedAdministrations = 1
	,@Language = N'English, Japanese, Сhinese'
	,@Currency = 'USD'


UPDATE [dbo].[Users] SET [RoleId] = 1 WHERE [Id] = 1
UPDATE [dbo].[Users] SET [RoleId] = 2 WHERE [Id] = 2
UPDATE [dbo].[Users] SET [RoleId] = 3 WHERE [Id] = 3
UPDATE [dbo].[Users] SET [RoleId] = 4 WHERE [Id] = 4
UPDATE [dbo].[Users] SET [RoleId] = 5 WHERE [Id] = 5
UPDATE [dbo].[Users] SET [RoleId] = 6 WHERE [Id] = 6
UPDATE [dbo].[Users] SET [RoleId] = 7 WHERE [Id] = 7
UPDATE [dbo].[Users] SET [RoleId] = 8 WHERE [Id] = 8
UPDATE [dbo].[Users] SET [RoleId] = 9 WHERE [Id] = 9
UPDATE [dbo].[Users] SET [RoleId] = 10 WHERE [Id] = 10
GO

GO
PRINT N'Update complete.';


GO
