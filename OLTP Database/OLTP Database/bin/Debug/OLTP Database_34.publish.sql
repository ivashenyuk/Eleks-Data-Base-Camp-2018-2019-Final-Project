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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)] COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[BankCards]...';


GO
CREATE TABLE [dbo].[BankCards] (
    [Id]                 INT           IDENTITY (1, 1) NOT NULL,
    [BankId]             INT           NOT NULL,
    [CardNumber]         VARCHAR (16)  NOT NULL,
    [ExpiryDateCard]     DATE          NOT NULL,
    [DigitsOnBackOfCard] TINYINT       NOT NULL,
    [IsConfirmedCard]    BIT           NULL,
    [CreatedAt]          DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Bank_Card_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Banks]...';


GO
CREATE TABLE [dbo].[Banks] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [Name]               NVARCHAR (255) NOT NULL,
    [MinMoneyToWithdraw] MONEY          NOT NULL,
    [Commission]         FLOAT (53)     NOT NULL,
    [TimeOfProcessing]   BIGINT         NOT NULL,
    [Description]        NVARCHAR (1)   NULL,
    [CreatedAt]          DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_Bank_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Bets]...';


GO
CREATE TABLE [dbo].[Bets] (
    [Id]                          INT           IDENTITY (1, 1) NOT NULL,
    [MatchId]                     INT           NOT NULL,
    [UserId]                      INT           NOT NULL,
    [ScoreHomeTeam]               INT           NULL,
    [ScoreAwayTeam]               INT           NULL,
    [ChanceToWin]                 FLOAT (53)    NOT NULL,
    [PutMoney]                    MONEY         NOT NULL,
    [Tax]                         FLOAT (53)    NOT NULL,
    [CommissionOfSite]            MONEY         NOT NULL,
    [Prize]                       MONEY         NOT NULL,
    [Date]                        DATETIME2 (7) NOT NULL,
    [CoefficientHomeWin]          FLOAT (53)    NOT NULL,
    [CoefficientAwayWin]          FLOAT (53)    NOT NULL,
    [CoefficientDraw]             FLOAT (53)    NOT NULL,
    [CoefficientHomeWinOrAwayWin] FLOAT (53)    NOT NULL,
    [CoefficientAwayWinOrDraw]    FLOAT (53)    NOT NULL,
    [CoefficientHomeWinOrDraw]    FLOAT (53)    NOT NULL,
    [HandicapValue]               FLOAT (53)    NOT NULL,
    [CoefficientHandicap]         FLOAT (53)    NOT NULL,
    [Over]                        FLOAT (53)    NOT NULL,
    [Under]                       FLOAT (53)    NOT NULL,
    [Total]                       FLOAT (53)    NOT NULL,
    [MaxAmountPutMoney]           MONEY         NOT NULL,
    [Result]                      BIT           NULL,
    [CreatedAt]                   DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Bet_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Clubs]...';


GO
CREATE TABLE [dbo].[Clubs] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (255) NOT NULL,
    [ClubManagerId] INT            NOT NULL,
    [CreatedAt]     DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_Club_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Events]...';


GO
CREATE TABLE [dbo].[Events] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [MatchId]          INT            NOT NULL,
    [DescriptionEvent] NVARCHAR (500) NULL,
    [ScoreHomeTeam]    INT            NOT NULL,
    [ScoreAwayTeam]    INT            NOT NULL,
    [Time]             TIME (7)       NULL,
    [CreatedAt]        DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_Event_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Locations]...';


GO
CREATE TABLE [dbo].[Locations] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [City]      NVARCHAR (500) NOT NULL,
    [State]     NVARCHAR (500) NOT NULL,
    [Country]   NVARCHAR (500) NOT NULL,
    [CreatedAt] DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_Location_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Matches]...';


GO
CREATE TABLE [dbo].[Matches] (
    [Id]             INT           IDENTITY (1, 1) NOT NULL,
    [HomeTeamId]     INT           NOT NULL,
    [AwayTeamId]     INT           NOT NULL,
    [ManagerId]      INT           NULL,
    [LocationId]     INT           NOT NULL,
    [SportId]        INT           NOT NULL,
    [TournamentId]   INT           NULL,
    [Date]           DATETIME2 (7) NOT NULL,
    [HowLongIsGoing] TIME (7)      NULL,
    [CreatedAt]      DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Matche_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Organizations]...';


GO
CREATE TABLE [dbo].[Organizations] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (255) NOT NULL,
    [CreatedAt] DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_Organization_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Passports]...';


GO
CREATE TABLE [dbo].[Passports] (
    [Id]                     INT            IDENTITY (1, 1) NOT NULL,
    [PassportCode]           VARCHAR (15)   NULL,
    [Seria]                  NVARCHAR (5)   NULL,
    [BirthDay]               DATE           NULL,
    [FirstName]              NVARCHAR (255) NOT NULL,
    [LastName]               NVARCHAR (255) NOT NULL,
    [PhotoPage1]             INT            NULL,
    [PhotoPage2]             INT            NULL,
    [PhotoRegistration]      INT            NULL,
    [PhotoIDOwner]           INT            NULL,
    [PhotoOwnerWithPassport] INT            NULL,
    [CreatedAt]              DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_Passport_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Photos]...';


GO
CREATE TABLE [dbo].[Photos] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (255)  NOT NULL,
    [Path]      NVARCHAR (2000) NOT NULL,
    [CreatedAt] DATETIME2 (7)   NOT NULL,
    CONSTRAINT [PK_Photo_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Purses]...';


GO
CREATE TABLE [dbo].[Purses] (
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [Balance]         MONEY         NOT NULL,
    [StayPlayBalance] MONEY         NOT NULL,
    [PaidBonus]       MONEY         NOT NULL,
    [Currency]        VARCHAR (3)   NOT NULL,
    [CreatedAt]       DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Purse_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Roles]...';


GO
CREATE TABLE [dbo].[Roles] (
    [Id]          INT             IDENTITY (1, 1) NOT NULL,
    [Role]        NVARCHAR (50)   NOT NULL,
    [Description] NVARCHAR (1000) NULL,
    [CreatedAt]   DATETIME2 (7)   NOT NULL,
    CONSTRAINT [PK_Role_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Sports]...';


GO
CREATE TABLE [dbo].[Sports] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (255) NOT NULL,
    [CreatedAt] DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_Sport_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Teams]...';


GO
CREATE TABLE [dbo].[Teams] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [ClubId]        INT            NULL,
    [TeamManagerId] INT            NULL,
    [Name]          NVARCHAR (255) NOT NULL,
    [CreatedAt]     DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_Team_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Tournaments]...';


GO
CREATE TABLE [dbo].[Tournaments] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (255) NOT NULL,
    [OrganizationId] INT            NULL,
    [CreatedAt]      DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_Tournaments_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Transactions]...';


GO
CREATE TABLE [dbo].[Transactions] (
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [UserId]          INT           NOT NULL,
    [BetId]           INT           NOT NULL,
    [Amount]          MONEY         NOT NULL,
    [TransactionDate] DATETIME2 (7) NOT NULL,
    [CreatedAt]       DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Transaction_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Users]...';


GO
CREATE TABLE [dbo].[Users] (
    [Id]                         INT            IDENTITY (1, 1) NOT NULL,
    [PassportId]                 INT            NOT NULL,
    [RoleId]                     INT            NOT NULL,
    [LocationId]                 INT            NULL,
    [BankCardId]                 INT            NULL,
    [PurseId]                    INT            NOT NULL,
    [Language]                   NVARCHAR (255) NOT NULL,
    [Email]                      NVARCHAR (100) NOT NULL,
    [Phone]                      NVARCHAR (15)  NOT NULL,
    [HashPassword]               NVARCHAR (200) NOT NULL,
    [Age]                        INT            NOT NULL,
    [EmailIsConfirmed]           BIT            NOT NULL,
    [PhoneIsConfirmed]           BIT            NOT NULL,
    [IsConfirmedAdministrations] BIT            NOT NULL,
    [CreatedAt]                  DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_User_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[DF_Created_At_BankCards]...';


GO
ALTER TABLE [dbo].[BankCards]
    ADD CONSTRAINT [DF_Created_At_BankCards] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Banks]...';


GO
ALTER TABLE [dbo].[Banks]
    ADD CONSTRAINT [DF_Created_At_Banks] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Score_Home_Team_Bets]...';


GO
ALTER TABLE [dbo].[Bets]
    ADD CONSTRAINT [DF_Score_Home_Team_Bets] DEFAULT 0 FOR [ScoreHomeTeam];


GO
PRINT N'Creating [dbo].[DF_Score_Away_Team_Bets]...';


GO
ALTER TABLE [dbo].[Bets]
    ADD CONSTRAINT [DF_Score_Away_Team_Bets] DEFAULT 0 FOR [ScoreAwayTeam];


GO
PRINT N'Creating [dbo].[DF_Put_Money_Bets]...';


GO
ALTER TABLE [dbo].[Bets]
    ADD CONSTRAINT [DF_Put_Money_Bets] DEFAULT (0.00) FOR [PutMoney];


GO
PRINT N'Creating [dbo].[DF_Created_At_Bets]...';


GO
ALTER TABLE [dbo].[Bets]
    ADD CONSTRAINT [DF_Created_At_Bets] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Clubs]...';


GO
ALTER TABLE [dbo].[Clubs]
    ADD CONSTRAINT [DF_Created_At_Clubs] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Events]...';


GO
ALTER TABLE [dbo].[Events]
    ADD CONSTRAINT [DF_Created_At_Events] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Locations]...';


GO
ALTER TABLE [dbo].[Locations]
    ADD CONSTRAINT [DF_Created_At_Locations] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Matches]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [DF_Created_At_Matches] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Organizations]...';


GO
ALTER TABLE [dbo].[Organizations]
    ADD CONSTRAINT [DF_Created_At_Organizations] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Passports]...';


GO
ALTER TABLE [dbo].[Passports]
    ADD CONSTRAINT [DF_Created_At_Passports] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Photos]...';


GO
ALTER TABLE [dbo].[Photos]
    ADD CONSTRAINT [DF_Created_At_Photos] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Balance_Purses]...';


GO
ALTER TABLE [dbo].[Purses]
    ADD CONSTRAINT [DF_Balance_Purses] DEFAULT (0.00) FOR [Balance];


GO
PRINT N'Creating [dbo].[DF_Stay_Play_Balance_Purses]...';


GO
ALTER TABLE [dbo].[Purses]
    ADD CONSTRAINT [DF_Stay_Play_Balance_Purses] DEFAULT (0.00) FOR [StayPlayBalance];


GO
PRINT N'Creating [dbo].[DF_Paid_Bonus_Purses]...';


GO
ALTER TABLE [dbo].[Purses]
    ADD CONSTRAINT [DF_Paid_Bonus_Purses] DEFAULT (0.00) FOR [PaidBonus];


GO
PRINT N'Creating [dbo].[DF_Created_At_Purses]...';


GO
ALTER TABLE [dbo].[Purses]
    ADD CONSTRAINT [DF_Created_At_Purses] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Roles]...';


GO
ALTER TABLE [dbo].[Roles]
    ADD CONSTRAINT [DF_Created_At_Roles] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Sports]...';


GO
ALTER TABLE [dbo].[Sports]
    ADD CONSTRAINT [DF_Created_At_Sports] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Teams]...';


GO
ALTER TABLE [dbo].[Teams]
    ADD CONSTRAINT [DF_Created_At_Teams] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD CONSTRAINT [DF_Created_At_Tournaments] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Transactions]...';


GO
ALTER TABLE [dbo].[Transactions]
    ADD CONSTRAINT [DF_Created_At_Transactions] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[DF_Created_At_Users]...';


GO
ALTER TABLE [dbo].[Users]
    ADD CONSTRAINT [DF_Created_At_Users] DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating [dbo].[FK_Bank_Id_BankCards_Users]...';


GO
ALTER TABLE [dbo].[BankCards]
    ADD CONSTRAINT [FK_Bank_Id_BankCards_Users] FOREIGN KEY ([BankId]) REFERENCES [dbo].[Banks] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Match_Bets_Events]...';


GO
ALTER TABLE [dbo].[Bets]
    ADD CONSTRAINT [FK_Match_Bets_Events] FOREIGN KEY ([MatchId]) REFERENCES [dbo].[Events] ([Id]);


GO
PRINT N'Creating [dbo].[FK_User_Bets_Users]...';


GO
ALTER TABLE [dbo].[Bets]
    ADD CONSTRAINT [FK_User_Bets_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Club_Manager_Id_Clubs_Users]...';


GO
ALTER TABLE [dbo].[Clubs]
    ADD CONSTRAINT [FK_Club_Manager_Id_Clubs_Users] FOREIGN KEY ([ClubManagerId]) REFERENCES [dbo].[Users] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Match_Id_Events_Matches]...';


GO
ALTER TABLE [dbo].[Events]
    ADD CONSTRAINT [FK_Match_Id_Events_Matches] FOREIGN KEY ([MatchId]) REFERENCES [dbo].[Matches] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Home_Team_Id_Matches_Teams]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [FK_Home_Team_Id_Matches_Teams] FOREIGN KEY ([HomeTeamId]) REFERENCES [dbo].[Teams] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Away_Team_Id_Matches_Teams]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [FK_Away_Team_Id_Matches_Teams] FOREIGN KEY ([AwayTeamId]) REFERENCES [dbo].[Teams] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Manager_Id_Matches_Users]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [FK_Manager_Id_Matches_Users] FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Users] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Location_Id_Matches_Locations]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [FK_Location_Id_Matches_Locations] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Locations] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Sport_Id_Matches_Sports]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [FK_Sport_Id_Matches_Sports] FOREIGN KEY ([SportId]) REFERENCES [dbo].[Sports] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Tournament_Id_Matches_Tournaments]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [FK_Tournament_Id_Matches_Tournaments] FOREIGN KEY ([TournamentId]) REFERENCES [dbo].[Tournaments] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Photo_Page_1_Passports_Photos]...';


GO
ALTER TABLE [dbo].[Passports]
    ADD CONSTRAINT [FK_Photo_Page_1_Passports_Photos] FOREIGN KEY ([PhotoPage1]) REFERENCES [dbo].[Photos] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Photo_Page_2_Passports_Photos]...';


GO
ALTER TABLE [dbo].[Passports]
    ADD CONSTRAINT [FK_Photo_Page_2_Passports_Photos] FOREIGN KEY ([PhotoPage2]) REFERENCES [dbo].[Photos] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Photo_Page_Registration_Passports_Photos]...';


GO
ALTER TABLE [dbo].[Passports]
    ADD CONSTRAINT [FK_Photo_Page_Registration_Passports_Photos] FOREIGN KEY ([PhotoRegistration]) REFERENCES [dbo].[Photos] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Photo_ID_Owner_Passports_Photos]...';


GO
ALTER TABLE [dbo].[Passports]
    ADD CONSTRAINT [FK_Photo_ID_Owner_Passports_Photos] FOREIGN KEY ([PhotoIDOwner]) REFERENCES [dbo].[Photos] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Photo_Owner_With_Passport_Passports_Photos]...';


GO
ALTER TABLE [dbo].[Passports]
    ADD CONSTRAINT [FK_Photo_Owner_With_Passport_Passports_Photos] FOREIGN KEY ([PhotoOwnerWithPassport]) REFERENCES [dbo].[Photos] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Club_Id_Teams_Clubs]...';


GO
ALTER TABLE [dbo].[Teams]
    ADD CONSTRAINT [FK_Club_Id_Teams_Clubs] FOREIGN KEY ([ClubId]) REFERENCES [dbo].[Clubs] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Team_Manager_Id_Teams_Users]...';


GO
ALTER TABLE [dbo].[Teams]
    ADD CONSTRAINT [FK_Team_Manager_Id_Teams_Users] FOREIGN KEY ([TeamManagerId]) REFERENCES [dbo].[Users] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Organization_Id_Tournaments_Organizations]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD CONSTRAINT [FK_Organization_Id_Tournaments_Organizations] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([Id]);


GO
PRINT N'Creating [dbo].[FK_User_Id_Transactions_Users]...';


GO
ALTER TABLE [dbo].[Transactions]
    ADD CONSTRAINT [FK_User_Id_Transactions_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Bet_Id_Transactions_Bets]...';


GO
ALTER TABLE [dbo].[Transactions]
    ADD CONSTRAINT [FK_Bet_Id_Transactions_Bets] FOREIGN KEY ([BetId]) REFERENCES [dbo].[Bets] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Passport_Users_Passports]...';


GO
ALTER TABLE [dbo].[Users]
    ADD CONSTRAINT [FK_Passport_Users_Passports] FOREIGN KEY ([PassportId]) REFERENCES [dbo].[Passports] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Role_Users_Roles]...';


GO
ALTER TABLE [dbo].[Users]
    ADD CONSTRAINT [FK_Role_Users_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Location_Users_Locations]...';


GO
ALTER TABLE [dbo].[Users]
    ADD CONSTRAINT [FK_Location_Users_Locations] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Locations] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Bank_Card_Users_BankCards]...';


GO
ALTER TABLE [dbo].[Users]
    ADD CONSTRAINT [FK_Bank_Card_Users_BankCards] FOREIGN KEY ([BankCardId]) REFERENCES [dbo].[BankCards] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Purse_Users_Purses]...';


GO
ALTER TABLE [dbo].[Users]
    ADD CONSTRAINT [FK_Purse_Users_Purses] FOREIGN KEY ([PurseId]) REFERENCES [dbo].[Purses] ([Id]);


GO
PRINT N'Creating [dbo].[CK_User_Age_Users]...';


GO
ALTER TABLE [dbo].[Users]
    ADD CONSTRAINT [CK_User_Age_Users] CHECK ([Age] >= 18);


GO
PRINT N'Creating [dbo].[TeamAdd]...';


GO
CREATE PROCEDURE [dbo].[TeamAdd]
	@ClubId INT
	,@TeamManagerId INT
	,@Name NVARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO [dbo].[Teams]([ClubId], [TeamManagerId], [Name]) 
				VALUES (NULLIF(@ClubId, 0), NULLIF(@TeamManagerId, 0), @Name)
			DECLARE @TeamId INT = SCOPE_IDENTITY()
			COMMIT;
			RETURN @TeamId
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN
				ROLLBACK
				;THROW
			END;
			RETURN -1
		END CATCH
END
GO
PRINT N'Creating [dbo].[TeamGet]...';


GO
CREATE PROCEDURE [dbo].[TeamGet]
	@TeamId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@TeamId IS NULL)
			BEGIN
				SELECT * FROM [dbo].[Teams]
			END
			ELSE
			BEGIN
				SELECT TOP 1 * FROM [dbo].[Teams] WHERE [Id] = ISNULL(@TeamId, [Id])
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
PRINT N'Creating [dbo].[TeamRemove]...';


GO
CREATE PROCEDURE [dbo].[TeamRemove]
	@TeamId INT
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			DELETE FROM [dbo].[Teams] WHERE [Id] = @TeamId
			COMMIT
			RETURN 1
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN 
				ROLLBACK
				;THROW
			END
			RETURN 0
		END CATCH
	
END
GO
PRINT N'Creating [dbo].[TeamUpdate]...';


GO
CREATE PROCEDURE [dbo].[TeamUpdate]
	 @TeamId INT
	,@ClubId INT = NULL
	,@TeamManagerId INT = NULL
	,@Name NVARCHAR(255) = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			
			UPDATE [dbo].[Teams] SET [ClubId] = ISNULL(NULLIF(@ClubId, 0), [ClubId])
									,[TeamManagerId] = ISNULL(NULLIF(@TeamManagerId, 0), [TeamManagerId])
									,[Name] = ISNULL(@Name, [Name]) WHERE [Id] = @TeamId
			
			COMMIT
			IF (@@ROWCOUNT > 0)
				RETURN 1
			ELSE 
				RETURN 0
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN 
				ROLLBACK
				;THROW
			END
			RETURN 0
		END CATCH
END
GO
PRINT N'Creating [dbo].[UserDelete]...';


GO
CREATE PROCEDURE [dbo].[UserDelete]
	@UserId INT
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			DECLARE @PurseId INT,
					@PassportId INT,
					@BankCardId INT
			SELECT TOP 1 @PurseId = [user].[PurseId], 
							@PassportId = [user].[PassportId],
							@BankCardId = [user].[BankCardId] 
								FROM [dbo].[Users] AS [user] WHERE [user].[Id] = @UserId 

			--deleting user account
			DELETE FROM [dbo].[Users] WHERE [Id] = @UserId

			-- deleting user purse
			IF(ISNULL(@PurseId, 0) <> 0)
				DELETE FROM [dbo].[Purses] WHERE [Id] = @PurseId
		
			-- deleting user bank card
			IF(ISNULL(@BankCardId, 0) <> 0)
				DELETE FROM [dbo].[BankCards] WHERE [Id] = @BankCardId

			-- deleting user passport and photos
			IF(ISNULL(@PassportId, 0) <> 0)
				BEGIN 
					DECLARE @UserPhotosId TABLE (
						[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1)
						,[PhotoId] INT NULL
					)

					INSERT INTO @UserPhotosId([PhotoId]) 
						SELECT [PhotoId]
							FROM ( SELECT TOP 1 [passport].[Id]
										,[passport].[PhotoPage1]
										,[passport].[PhotoPage2]
										,[passport].[PhotoIDOwner]
										,[passport].[PhotoOwnerWithPassport]
										,[passport].[PhotoRegistration] 
										FROM [dbo].[Passports] AS [passport]
										WHERE [passport].[Id] = @PassportId
									) AS passPhotos
									UNPIVOT (
										PhotoId FOR TempPhotoName
											IN([PhotoPage1], [PhotoPage2], [PhotoIDOwner]
												,[PhotoOwnerWithPassport], [PhotoRegistration] )

									) AS [unpivot]
					--deleting user photos
					DELETE FROM [dbo].[Photos] WHERE [Id] IN (SELECT [PhotoId] FROM @UserPhotosId) 
				
					--deleting user passport
					DELETE FROM [dbo].[Passports] WHERE [Id] = @PassportId
				END

			COMMIT
			IF (ISNULL(@PurseId, 0) <> 0)
				RETURN 1
			ELSE
				RETURN 0
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN 
				ROLLBACK
				;THROW
			END
			RETURN 0
		END CATCH
END
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
	,@EmailIsConfirmed BIT = 0
	,@PhoneIsConfirmed BIT = 0
	,@IsConfirmedAdministrations BIT = 0
	,@Language NVARCHAR(255) = N'English'
	,@Currency VARCHAR(3) = 'USD'
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

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
											, @EmailIsConfirmed
											, @PhoneIsConfirmed
											, @IsConfirmedAdministrations)

			SET @UserId = SCOPE_IDENTITY()

			COMMIT
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN
				ROLLBACK
				;THROW

			END
				
		END CATCH

	

	RETURN @UserId
END
GO
PRINT N'Creating [dbo].[UserUpdate]...';


GO
CREATE PROCEDURE [dbo].[UserUpdate]
	@UserId INT
	,@BirthDay DATE = NULL
	,@Email NVARCHAR(100) = NULL
	,@Phone NVARCHAR(15) = NULL
	,@HashPassword  NVARCHAR(200) = NULL
	,@EmailIsConfirmed BIT = NULL
	,@PhoneIsConfirmed BIT = NULL
	,@IsConfirmedAdministrations BIT = NULL
	,@Language NVARCHAR(255) = NULL
	,@RoleId INT = NULL
	,@LocationId INT = NULL
AS
BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON

	BEGIN TRAN
		BEGIN TRY
			IF (@UserId IS NULL)
				THROW 51000, 'User ID can''t be empty.', 1;
			
			
			DECLARE @Age INT = NULL
					
			IF (@BirthDay IS NOT NULL)
					SET @Age = DATEDIFF ( YEAR , @BirthDay, GETDATE()) - (CASE WHEN GETDATE() < DATEADD(yyyy,DATEDIFF(yyyy,@BirthDay,GETDATE()),@BirthDay) THEN 1 ELSE 0 END)

			--DECLARE @PassportId INT = NULL
			--		,@PurseId INT = NULL
			--SELECT TOP 1 @PassportId = [PassportId], @PurseId = [PurseId] FROM [dbo].[Users] WHERE [Id] = @UserId

			---- updating user passport
			--UPDATE [dbo].[Passports] 
			--	SET [FirstName] = N''
			--	, [LastName]  = N''
			--	, [BirthDay]  = N''
			--	WHERE [Id] = @PassportId
				
			
					
			
			---- updating user purse
			--IF (@PurseId IS NOT NULL)
			--	UPDATE [dbo].[Purses] SET [Currency] = @Currency WHERE [Id] = @PurseId
			
			-- updating user account
			UPDATE [dbo].[Users] SET 
									[RoleId] = ISNULL(NULLIF(@RoleId, 0), [RoleId])
									, [Email] = ISNULL(@Email, [Email])
									, [Phone] = ISNULL(@Phone, [Phone])
									, [HashPassword] = ISNULL(@HashPassword, [HashPassword])
									, [Language] = ISNULL(@Language, [Language])
									, [Age] = ISNULL(@Age, [Age])
									, [EmailIsConfirmed] = ISNULL(@EmailIsConfirmed, [EmailIsConfirmed])
									, [PhoneIsConfirmed] = ISNULL(@PhoneIsConfirmed, [PhoneIsConfirmed])
									, [IsConfirmedAdministrations] = ISNULL(@IsConfirmedAdministrations, [IsConfirmedAdministrations])
									WHERE [Id] = @UserId
			COMMIT
			RETURN 1
		END TRY
		BEGIN CATCH
			IF (@@ERROR <> 0)
			BEGIN
				ROLLBACK
				;THROW
			END
			RETURN 0
		END CATCH	
END
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
