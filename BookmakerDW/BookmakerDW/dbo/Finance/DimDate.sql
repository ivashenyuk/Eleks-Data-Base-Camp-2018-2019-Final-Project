CREATE TABLE [dbo].[DimDate]
(
	[Id] INT NOT NULL PRIMARY KEY
	,[FullDate]						date			not null
	,[Year]							smallint		not null
	,[MonthEnglishName]				nvarchar(15)	not null
	,[MonthNumberOfYear]			tinyint			not null
	,[DayOfWeekEngilshName]			nvarchar(15)	not null
	,[DayNumberOfMonth]				tinyint			not	NULL
	,[CalendarQuarter]				TINYINT			NOT NULL
	,[CalendarSemester]				tinyint			not null
)
