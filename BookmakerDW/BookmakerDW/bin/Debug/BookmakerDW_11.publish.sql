﻿/*
Deployment script for BookmakerDW

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BookmakerDW"
:setvar DefaultFilePrefix "BookmakerDW"
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
/*
The column [dbo].[FactFinance].[LocationId] on table [dbo].[FactFinance] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [dbo].[FactFinance].[SportId] on table [dbo].[FactFinance] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [dbo].[FactFinance].[TournamentId] on table [dbo].[FactFinance] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[FactFinance])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping [dbo].[DF_Created_At_FactFinance]...';


GO
ALTER TABLE [dbo].[FactFinance] DROP CONSTRAINT [DF_Created_At_FactFinance];


GO
PRINT N'Dropping [dbo].[FK_Match_FactFinance_Events]...';


GO
ALTER TABLE [dbo].[FactFinance] DROP CONSTRAINT [FK_Match_FactFinance_Events];


GO
PRINT N'Dropping [dbo].[FK_User_FactFinance_Users]...';


GO
ALTER TABLE [dbo].[FactFinance] DROP CONSTRAINT [FK_User_FactFinance_Users];


GO
PRINT N'Dropping [dbo].[FK_Date_FactFinance_DimDate]...';


GO
ALTER TABLE [dbo].[FactFinance] DROP CONSTRAINT [FK_Date_FactFinance_DimDate];


GO
PRINT N'Starting rebuilding table [dbo].[FactFinance]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_FactFinance] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [MatchId]      INT           NOT NULL,
    [UserId]       INT           NOT NULL,
    [DateId]       INT           NOT NULL,
    [LocationId]   INT           NOT NULL,
    [TournamentId] INT           NOT NULL,
    [SportId]      INT           NOT NULL,
    [Tax]          MONEY         NOT NULL,
    [Profit]       MONEY         NOT NULL,
    [CreatedAt]    DATETIME2 (7) CONSTRAINT [DF_Created_At_FactFinance] DEFAULT GETDATE() NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Bet_Id1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[FactFinance])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_FactFinance] ON;
        INSERT INTO [dbo].[tmp_ms_xx_FactFinance] ([Id], [MatchId], [UserId], [DateId], [Tax], [Profit], [CreatedAt])
        SELECT   [Id],
                 [MatchId],
                 [UserId],
                 [DateId],
                 [Tax],
                 [Profit],
                 [CreatedAt]
        FROM     [dbo].[FactFinance]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_FactFinance] OFF;
    END

DROP TABLE [dbo].[FactFinance];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_FactFinance]', N'FactFinance';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Bet_Id1]', N'PK_Bet_Id', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[FK_Match_FactFinance_Events]...';


GO
ALTER TABLE [dbo].[FactFinance] WITH NOCHECK
    ADD CONSTRAINT [FK_Match_FactFinance_Events] FOREIGN KEY ([MatchId]) REFERENCES [dbo].[DimMatch] ([Id]);


GO
PRINT N'Creating [dbo].[FK_User_FactFinance_Users]...';


GO
ALTER TABLE [dbo].[FactFinance] WITH NOCHECK
    ADD CONSTRAINT [FK_User_FactFinance_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[DimUser] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Date_FactFinance_DimDate]...';


GO
ALTER TABLE [dbo].[FactFinance] WITH NOCHECK
    ADD CONSTRAINT [FK_Date_FactFinance_DimDate] FOREIGN KEY ([DateId]) REFERENCES [dbo].[DimDate] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Location_FactFinance_DimLocation]...';


GO
ALTER TABLE [dbo].[FactFinance] WITH NOCHECK
    ADD CONSTRAINT [FK_Location_FactFinance_DimLocation] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[DimLocation] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Tournament_FactFinance_DimTournament]...';


GO
ALTER TABLE [dbo].[FactFinance] WITH NOCHECK
    ADD CONSTRAINT [FK_Tournament_FactFinance_DimTournament] FOREIGN KEY ([TournamentId]) REFERENCES [dbo].[DimTournament] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Sport_FactFinance_DimSport]...';


GO
ALTER TABLE [dbo].[FactFinance] WITH NOCHECK
    ADD CONSTRAINT [FK_Sport_FactFinance_DimSport] FOREIGN KEY ([SportId]) REFERENCES [dbo].[DimSport] ([Id]);


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


EXEC [dbo].[FillDimDate]
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[FactFinance] WITH CHECK CHECK CONSTRAINT [FK_Match_FactFinance_Events];

ALTER TABLE [dbo].[FactFinance] WITH CHECK CHECK CONSTRAINT [FK_User_FactFinance_Users];

ALTER TABLE [dbo].[FactFinance] WITH CHECK CHECK CONSTRAINT [FK_Date_FactFinance_DimDate];

ALTER TABLE [dbo].[FactFinance] WITH CHECK CHECK CONSTRAINT [FK_Location_FactFinance_DimLocation];

ALTER TABLE [dbo].[FactFinance] WITH CHECK CHECK CONSTRAINT [FK_Tournament_FactFinance_DimTournament];

ALTER TABLE [dbo].[FactFinance] WITH CHECK CHECK CONSTRAINT [FK_Sport_FactFinance_DimSport];


GO
PRINT N'Update complete.';


GO
