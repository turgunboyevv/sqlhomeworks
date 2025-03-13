-- method-1
DECLARE @date DATE = '20250313'; -- Kalendar chiqariladigan sanani shu yerda belgilaysiz

WITH CalendarCTE AS (
    SELECT 
        DATEADD(DAY, number, DATEFROMPARTS(YEAR(@date), MONTH(@date), 1)) AS FullDate
    FROM master.dbo.spt_values
    WHERE type = 'P' AND number < 42
),
DateInfo AS (
    SELECT 
        FullDate,
        DATEPART(DAY, FullDate) AS DayNumber,
        DATENAME(WEEKDAY, FullDate) AS DayName,
        DATEPART(WEEKDAY, FullDate) AS WeekDayNumber,
        DATEPART(WEEK, FullDate) - DATEPART(WEEK, DATEFROMPARTS(YEAR(@date), MONTH(@date), 1)) + 1 AS WeekNumber
    FROM CalendarCTE
    WHERE MONTH(FullDate) = MONTH(@date) AND YEAR(FullDate) = YEAR(@date)
)
SELECT 
    MAX(CASE WHEN DayName = 'Sunday' THEN DayNumber ELSE NULL END) AS Sunday,
    MAX(CASE WHEN DayName = 'Monday' THEN DayNumber ELSE NULL END) AS Monday,
    MAX(CASE WHEN DayName = 'Tuesday' THEN DayNumber ELSE NULL END) AS Tuesday,
    MAX(CASE WHEN DayName = 'Wednesday' THEN DayNumber ELSE NULL END) AS Wednesday,
    MAX(CASE WHEN DayName = 'Thursday' THEN DayNumber ELSE NULL END) AS Thursday,
    MAX(CASE WHEN DayName = 'Friday' THEN DayNumber ELSE NULL END) AS Friday,
    MAX(CASE WHEN DayName = 'Saturday' THEN DayNumber ELSE NULL END) AS Saturday
FROM DateInfo
GROUP BY WeekNumber
ORDER BY WeekNumber;

-- method-2
DECLARE @date DATE = '20250313'; -- Bu yerda sanani belgilaysiz

WITH CalendarCTE AS (
    SELECT 
        DATEFROMPARTS(YEAR(@date), MONTH(@date), 1) AS FullDate,
        1 AS DayNumber,
        DATEPART(WEEKDAY, DATEFROMPARTS(YEAR(@date), MONTH(@date), 1)) AS WeekDayNumber

    UNION ALL

    SELECT 
        DATEADD(DAY, 1, FullDate),
        DayNumber + 1,
        DATEPART(WEEKDAY, DATEADD(DAY, 1, FullDate))
    FROM CalendarCTE
    WHERE MONTH(FullDate) = MONTH(@date)
)
SELECT 
    MAX(CASE WHEN WeekDayNumber = 1 THEN DayNumber ELSE NULL END) AS Sunday,
    MAX(CASE WHEN WeekDayNumber = 2 THEN DayNumber ELSE NULL END) AS Monday,
    MAX(CASE WHEN WeekDayNumber = 3 THEN DayNumber ELSE NULL END) AS Tuesday,
    MAX(CASE WHEN WeekDayNumber = 4 THEN DayNumber ELSE NULL END) AS Wednesday,
    MAX(CASE WHEN WeekDayNumber = 5 THEN DayNumber ELSE NULL END) AS Thursday,
    MAX(CASE WHEN WeekDayNumber = 6 THEN DayNumber ELSE NULL END) AS Friday,
    MAX(CASE WHEN WeekDayNumber = 7 THEN DayNumber ELSE NULL END) AS Saturday
FROM CalendarCTE
GROUP BY DATEPART(WEEK, FullDate)
OPTION (MAXRECURSION 100);

