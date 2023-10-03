# Casualties of Road Accidents in 2023
![Road Accident](https://img.freepik.com/free-vector/emergency-team-isometric-composition_1284-25471.jpg?w=2000)

## Feature
- [Dataset](https://www.kaggle.com/datasets/userabc12541874/traffic-accident/data) was obtained from Kaggle. 
- Data exploration and analysis used Excel for data cleaning (utilizing IFS function, filtering, and checking null and duplicate values), and Microsoft SQL Server for more in-depth exploration (employing CASE WHEN function, GROUP BY, DATENAME).
- Data visualization used [Tableau Dashboard](https://public.tableau.com/app/profile/projectoftheday/viz/CasualtiesofRoadAccidents/Dashboard1).

## Insights
- **Problem**: Traffic accidents are unavoidable and can be very detrimental because each accident typically results in at least minor damage, and there are also many casualties that occur as a result of traffic accidents. By understanding the number of casualties in the accident data collected, it is hoped that we can minimize the loss of lives.
- **Problem-solving**: My approach to minimizing casualties is to investigate the correlation between various factors and the number of fatalities, such as whether there is an increase in fatalities when accidents involve larger vehicles, and so on. To do this, conducting exploratory data analysis is necessary, and I will use SQL to gain further insights from the acquired data. Subsequently, the insights obtained from the SQL queries will be visualized into an interactive dashboard using Tableau for easier comprehension. The SQL query will be explained [here](#sql-query).
- **Conclusion**: From the exploration that has been conducted, it is known that the number of casualties is divided with the number of fatal casualties being approximately 50% more than injured casualties. Every column available in the data is related to the number of casualties in accidents, although it is somewhat challenging to draw conclusions because the number of casualties is evenly distributed across each column. Nevertheless, from the exploration, an evident increase in the number of casualties is observed when considering the cause of accidents, specifically, the figure for distracted driving is notably high. To reduce this number, drivers are urged to pay more attention to the road. The second factor strongly related to high casualties is driving at night; the data reveals that casualties occurring during late-night or early-morning accidents are significantly high.
- **Recommendation**: While the dataset provides valuable answers to some questions and allows for drawing conclusions and providing insights to reduce fatalities in accidents, it does not specify the exact location of where the accidents occurred, thus preventing immediate location-specific safety recommendations. And, a machine-learning method, such as forecasting, can be employed to predict the increasing number of fatalities in accidents, and they can also be utilized to prevent a surge in those numbers.

## SQL Query
Firstly, I'd like to understand what this dataset contains. 'roadaccident' is the name of the table I assigned when importing it into SSMS.

```sql
SELECT *
FROM roadaccident
```
Result: 
<a href="https://drive.google.com/uc?export=view&id=1c3hMEcodg4leDGkNP_iTdQoihNq6JmTN"><img src="https://drive.google.com/uc?export=view&id=1c3hMEcodg4leDGkNP_iTdQoihNq6JmTN" title="Click for the larger version." /></a>

From the table above, there are columns for Injuries and Fatalities. To calculate casualties, I only utilize the Injuries column because the Fatalities column is already inclusive within the Injuries column.


From the table above, there are columns for Injuries and Fatalities. To calculate casualties, I only utilize the Injuries column because the Fatalities column is already inclusive within the Injuries column.

**1. Find the total casualties and divide them into three types: Fatal Casualties, Injured Casualties, and Non-fatal Casualties.**

```sql
SELECT 
  SUM(Injuries) AS TotalCasualties,
  SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
  SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties,
  SUM(CASE WHEN Injuries = 0 AND Fatalities = 0 THEN Injuries END) AS NonFatal
FROM roadaccident
```

Result:\
<a href="https://drive.google.com/uc?export=view&id=1xlktpeLQ9eD55gR7IP5XbFLWZYHQRc0o"><img src="https://drive.google.com/uc?export=view&id=1xlktpeLQ9eD55gR7IP5XbFLWZYHQRc0o" title="Click for the larger version." /></a>

The total casualties amount to 24,760, with 18,817 being Fatal Casualties and 2,943 being Injured Casualties. From the extracted data, it can be concluded that this dataset has a high number of fatal casualties and does not contain any non-fatal casualties. Therefore, for further exploration, the non-fatal casualties category will not be included.


**2. The total casualties categorized by: vehicle type at the time of the accident, cause of the accident, weather conditions at the time of the accident, and the type of road being traveled on at the time of the accident.**

```sql
SELECT 
  Vehicle_Type,
  SUM(Injuries) AS TotalCasualties,
  SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
  SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY Vehicle_Type
ORDER BY 1
```

Result:\
<a href="https://drive.google.com/uc?export=view&id=1lBjazDqs4EVgj-xScz0reOkPPEhrA8Uq"><img src="https://drive.google.com/uc?export=view&id=1lBjazDqs4EVgj-xScz0reOkPPEhrA8Uq" title="Click for the larger version." /></a>

There are 4 types of vehicles recorded. The motorcycle type of vehicle has the highest total casualties, reaching 6,308, although its severity distribution among casualties is considered to be not as high compared to the others. This is because for Injured Casualties, the highest number of casualties occurs when riding a bus, while for Fatal Casualties, the highest number of casualties occurs when driving a car.


```sql
SELECT 
  Cause,
  SUM(Injuries) AS TotalCasualties,
  SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
  SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY Cause
ORDER BY 1
```

Result:\
<a href="https://drive.google.com/uc?export=view&id=1WUGGoYl_9FXnwwFkIXkOXqy1g1yFxINZ"><img src="https://drive.google.com/uc?export=view&id=1WUGGoYl_9FXnwwFkIXkOXqy1g1yFxINZ" title="Click for the larger version." /></a>

The cause of accidents that results in the most casualties is Distracted Driving. However, other causes still have relatively high numbers of casualties, both in terms of Injured Casualties and Fatal Casualties.

```sql
SELECT 
  Weather,
  SUM(Injuries) AS TotalCasualties,
  SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
  SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY Weather
ORDER BY 1
```

Result:\
<a href="https://drive.google.com/uc?export=view&id=1pLLXX_4-LG7VXQ58-Oew6Ezdc_Ot0IKV"><img src="https://drive.google.com/uc?export=view&id=1pLLXX_4-LG7VXQ58-Oew6Ezdc_Ot0IKV" title="Click for the larger version." /></a>

Rainy weather leads to more casualties, with Fatal Casualties reaching the figure of 5,005. From the table above, it can also be noted that even in clear weather, the number of fatalities in accidents remains high.

```sql
SELECT 
  Road_Type,
  SUM(Injuries) AS TotalCasualties,
  SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
  SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY Road_Type
ORDER BY 1
```

Result: \
<a href="https://drive.google.com/uc?export=view&id=1IAiPzNvD9hlfkHhUk35sMOnzCRbAbMZX"><img src="https://drive.google.com/uc?export=view&id=1IAiPzNvD9hlfkHhUk35sMOnzCRbAbMZX" title="Click for the larger version." /></a>

Fatalities in accidents tend to occur more frequently when the accident happens on a two-way road with a higher volume of vehicles.


**3. To find the total number of fatalities that have occurred in 2023, calculate them on a daily and hourly basis.**

```sql
SELECT 
  DATEPART(HH, Time) AS HourofAccident,
  SUM(Injuries) AS TotalCasualties,
  SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
  SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY DATEPART(HH, Time)
ORDER BY 1
```

Result: \
<a href="https://drive.google.com/uc?export=view&id=1U2ag12TSWYtzaVtEARbkeLgsb-jjuWd6"><img src="https://drive.google.com/uc?export=view&id=1U2ag12TSWYtzaVtEARbkeLgsb-jjuWd6" title="Click for the larger version." /></a>

There are many fatalities occurring at 1 a.m. in accidents. From the table, it can be concluded that accidents at night often result in fatalities.

```sql
SELECT	
  DATENAME(WEEKDAY, Date) AS DayofAccident,
  SUM(Injuries) AS TotalCasualties,
  SUM(CASE WHEN Injuries >= 1 AND Fatalities = 0 THEN Injuries END) AS InjuredCasualties,
  SUM(CASE WHEN Fatalities >= 1 THEN Injuries END) AS FatalCasualties
FROM roadaccident
GROUP BY DATENAME(WEEKDAY, Date)
```

Result: \
<a href="https://drive.google.com/uc?export=view&id=12YLXDE2QQatIhTGl-bhvPNb5E8bdcUPz"><img src="https://drive.google.com/uc?export=view&id=12YLXDE2QQatIhTGl-bhvPNb5E8bdcUPz" title="Click for the larger version." /></a>

The highest number of fatalities is observed in accidents that occur on Fridays, and the number of Injured Casualties appears to be significantly high during the weekends.

