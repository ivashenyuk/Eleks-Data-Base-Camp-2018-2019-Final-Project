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
AS
BEGIN
	DECLARE @UserId INT = -1
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Passports]([FirstName], [LastName], [BirthDay]) VALUES (@FirstName, @LastName, @BirthDay)
			DECLARE @PassportId INT = SCOPE_IDENTITY()
					,@Age INT = DATEDIFF ( YEAR , @BirthDay, GETDATE()) - (CASE WHEN GETDATE() < DATEADD(yyyy,DATEDIFF(yyyy,@BirthDay,GETDATE()),@BirthDay) THEN 1 ELSE 0 END)
			
			INSERT INTO [dbo].[Users]( [PassportId]
									, [Email]
									, [Phone]
									, [HashPassword]
									, [Language]
									, [Age]
									, [EmailIsConfirmed]
									, [PhoneIsConfirmed]
									, [IsConfirmedAdministrations]) 
									VALUES (@PassportId
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
PRINT N'Update complete.';


GO
