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

CREATE NONCLUSTERED INDEX  IX_FactFinance_DimMatchId		on [dbo].[FactFinance]([MatchId])
CREATE NONCLUSTERED INDEX  IX_FactFinance_DimUserId			on [dbo].[FactFinance]([UserId])
CREATE NONCLUSTERED INDEX  IX_FactFinance_DimDateId			ON [dbo].[FactFinance]([DateId])
CREATE NONCLUSTERED INDEX  IX_FactFinance_DimLocationId		ON [dbo].[FactFinance]([LocationId])
CREATE NONCLUSTERED INDEX  IX_FactFinance_DimTournamentId	ON [dbo].[FactFinance]([TournamentId])
CREATE NONCLUSTERED INDEX  IX_FactFinance_DimSportId		on [dbo].[FactFinance]([SportId])
CREATE NONCLUSTERED INDEX  IX_FactFinance_DimUserGroupId	on [dbo].[FactFinance]([UserGroupId])