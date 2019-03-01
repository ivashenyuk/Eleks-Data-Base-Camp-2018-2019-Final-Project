CREATE PROCEDURE [dbo].[FillDimDate]
	@fromYear SMALLINT = 2016
	,@fromMonth TINYINT = 1
	,@fromDay TINYINT = 1
AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		DECLARE @fromDate DATE =  TRY_CONVERT(DATE, CONCAT(@fromYear, N'/', @fromMonth, N'/', @fromDay));
		DECLARE @toDate DATE = DATEADD(YEAR, 10, @fromDate);
		
		;WITH RangeDate([Date]) AS (
			SELECT @fromDate AS [Date]
				UNION ALL
				SELECT DATEADD(DAY, 1, [Date]) FROM RangeDate
				WHERE DATEADD(DAY, 1, [Date]) < @toDate
		)
		INSERT INTO [dbo].[DimDate](
			[Id]
			,[FullDate]
			,[Year]
			,[MonthEnglishName]
			,[MonthNumberOfYear]
			,[DayOfWeekEngilshName]
			,[DayNumberOfMonth]
			,[CalendarQuarter]
			,[CalendarSemester]) 
				SELECT CONVERT(INT, FORMAT([DATE], 'yyyyMMdd')) AS [DateID]
						,[DATE]
						,YEAR([DATE])
						,DATENAME(MONTH, [DATE])
						,MONTH([DATE])
						,DATENAME(WEEKDAY, [DATE])
						,DAY([DATE])
						,DATEPART(QUARTER, [DATE])
						,((DATEPART(QUARTER,[DATE])-1)/2)+1
							FROM RangeDate
				OPTION(MAXRECURSION 4000)

		COMMIT
	END TRY
	BEGIN CATCH
		IF (@@ERROR <> 0)
			ROLLBACK;		
		THROW;
	END CATCH
END;