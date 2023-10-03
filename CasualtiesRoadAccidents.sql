SELECT *
FROM roadaccident

--Total Casualties, and by its severity.
SELECT 
	SUM(Injuries) AS TotalCasualties,
	SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
	SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties,
	SUM(CASE WHEN Injuries = 0 AND Fatalities = 0 THEN Injuries END) AS NonFatal
FROM roadaccident

--Since there's non-fatal casualties, the next query wouldn't add the non-fatal category

--Casualties categorized by the vehicle type involved in accidents
SELECT 
	Vehicle_Type,
	SUM(Injuries) AS TotalCasualties,
	SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
	SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY Vehicle_Type
ORDER BY 1

--Factors cause accidents
SELECT 
	Cause,
	SUM(Injuries) AS TotalCasualties,
	SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
	SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY Cause
ORDER BY 1

--Casualties categorized by the weather during accident
SELECT 
	Weather,
	SUM(Injuries) AS TotalCasualties,
	SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
	SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY Weather
ORDER BY 1

--Casualties categorized by road type when accidents occured
SELECT 
	Road_Type,
	SUM(Injuries) AS TotalCasualties,
	SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
	SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY Road_Type
ORDER BY 1

--Casualties per hour
SELECT 
	DATEPART(HH, Time) AS HourofAccident,
	SUM(Injuries) AS TotalCasualties,
	SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
	SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY DATEPART(HH, Time)
ORDER BY HourofAccident

--Casualties per day
SELECT	
	DATENAME(WEEKDAY, Date) AS DayofAccident,
	SUM(Injuries) AS TotalCasualties,
	SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
	SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY DATENAME(WEEKDAY, Date)