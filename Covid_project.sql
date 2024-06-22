 --Select * From Project..['Corona Virus Dataset$'] order by 3,4
Select * From Project..['Corona Virus Dataset$'] 

-- Q1. Write a code to check NULL values

select count(*) AS NullCount from ['Corona Virus Dataset$'] where Province is null or 
 [Country/Region] is null or 
 Latitude is null or
 Longitude is null or 
 [Date] is null or 
 Confirmed is null or
 Deaths is null or
 Recovered is null;

 ---check total number of rows

 SELECT COUNT(*) AS Row_Count FROM ['Corona Virus Dataset$'];

 ---Check what is start_date and end_date

 select MIN(Date) AS Starting_date, MAX(Date) AS ending_date From ['Corona Virus Dataset$']

 ----Number of month present in dataset
 SELECT MONTH(date) as months, COUNT(*) as count FROM ['Corona Virus Dataset$'] GROUP BY MONTH(date) 
 Order By MONTH(date);

 -- Q6. Find monthly average for confirmed, deaths, recovered

--Confirmed
SELECT 
    DATEADD(month, DATEDIFF(month, 0, date), 0) AS report_month,
    AVG(confirmed) AS avg_confirmed
FROM 
    ['Corona Virus Dataset$']
GROUP BY 
    DATEADD(month, DATEDIFF(month, 0, date), 0)
ORDER BY 
    report_month;

---Deaths
SELECT 
    DATEADD(month, DATEDIFF(month, 0, date), 0) AS report_month,
    AVG(Deaths) AS avg_Deaths
FROM 
    ['Corona Virus Dataset$']
GROUP BY 
    DATEADD(month, DATEDIFF(month, 0, date), 0)
ORDER BY 
    report_month;

----Recovered
SELECT 
    DATEADD(month, DATEDIFF(month, 0, date), 0) AS report_month,
    AVG(Recovered) AS avg_recovered
FROM 
    ['Corona Virus Dataset$']
GROUP BY 
    DATEADD(month, DATEDIFF(month, 0, date), 0)
ORDER BY 
    report_month;


-- Q7. Find most frequent value for confirmed, deaths, recovered each month 


WITH MonthlyConfirmedCounts AS (
    SELECT 
        DATEADD(month, DATEDIFF(month, 0, date), 0) AS report_month,
        confirmed,
        COUNT(*) AS count
    FROM 
        ['Corona Virus Dataset$']
    GROUP BY 
        DATEADD(month, DATEDIFF(month, 0, date), 0),
        confirmed
)
SELECT 
    report_month,
    confirmed,
    count
FROM 
    MonthlyConfirmedCounts
WHERE 
    count = (SELECT MAX(count) FROM MonthlyConfirmedCounts mc WHERE mc.report_month = MonthlyConfirmedCounts.report_month);
---
WITH MonthlyDeathsCounts AS (
    SELECT 
        DATEADD(month, DATEDIFF(month, 0, date), 0) AS report_month,
        Deaths,
        COUNT(*) AS count
    FROM 
        ['Corona Virus Dataset$']
    GROUP BY 
        DATEADD(month, DATEDIFF(month, 0, date), 0),
        Deaths
)
SELECT 
    report_month,
    Deaths,
    count
FROM 
    MonthlyDeathsCounts
WHERE 
    count = (SELECT MAX(count) FROM MonthlyDeathsCounts mc WHERE mc.report_month = MonthlyDeathsCounts.report_month);

--
WITH MonthlyRecoveredCounts AS (
    SELECT 
        DATEADD(month, DATEDIFF(month, 0, date), 0) AS report_month,
        recovered,
        COUNT(*) AS count
    FROM 
        ['Corona Virus Dataset$']
    GROUP BY 
        DATEADD(month, DATEDIFF(month, 0, date), 0),
        recovered
)
SELECT 
    report_month,
    recovered,
    count
FROM 
    MonthlyRecoveredCounts
WHERE 
    count = (SELECT MAX(count) FROM MonthlyRecoveredCounts mc WHERE mc.report_month = MonthlyRecoveredCounts.report_month);


---- Q Find minimum values for confirmed, deaths, recovered per year

Select
    YEAR([Date]) AS YEAR,
	MIN(Confirmed) AS Min_Confirm,
	MIN(Deaths) AS Min_Death,
	MIN(Recovered) AS Min_Recoverd
From 
    ['Corona Virus Dataset$']
GROUP BY
    YEAR([Date])
ORDER BY
    YEAR([Date]);


---Q Find maximum values of confirmed, deaths, recovered per year

Select
    YEAR([Date]) AS YEAR,
	MAX(Confirmed) AS Min_Confirm,
	MAX(Deaths) AS Min_Death,
	MAX(Recovered) AS Min_Recoverd
From 
    ['Corona Virus Dataset$']
GROUP BY
    YEAR([Date])
ORDER BY
    YEAR([Date]);


---Q. The total number of case of confirmed, deaths, recovered each month

Select
    Month([Date]) AS MONTH,
	SUM(Confirmed) AS Confirm,
	SUM(Deaths) AS Death,
	SUM(Recovered) AS Recover
From 
    ['Corona Virus Dataset$']
GROUP BY
    MONTH([Date])
ORDER BY
    MONTH([Date]);

-- Q11. Check how corona virus spread out with respect to confirmed case

Select
 Count(Confirmed) AS Confirmed_case,
 AVG(CONVERT(BIGINT, Confirmed)) AS Avg_Confirm,
 SUM(POWER(CONVERT(BIGINT, Confirmed) - Confirm_Cases.Avg_Confirm, 2))/ COUNT(Confirmed) AS Varience
 From ['Corona Virus Dataset$'],
 (SELECT AVG(CONVERT(BIGINT,Confirmed)) AS Avg_Confirm FROM ['Corona Virus Dataset$']) AS Confirm_Cases;


-- Q12. Check how corona virus spread out with respect to death case per month

Select
 Count(Deaths) AS Death_case,
 AVG(CONVERT(BIGINT, Deaths)) AS Avg_Death,
 SUM(POWER(CONVERT(BIGINT, Deaths) - Death_Cases.Avg_Death, 2))/ COUNT(Deaths) AS Varience
 From ['Corona Virus Dataset$'],
 (SELECT AVG(CONVERT(BIGINT,Deaths)) AS Avg_Death FROM ['Corona Virus Dataset$']) AS Death_Cases;

 -- Q13. Check how corona virus spread out with respect to recovered case
 Select
 Count(Recovered) AS Recover_case,
 AVG(CONVERT(BIGINT, Recovered)) AS Avg_recover,
 SUM(POWER(CONVERT(BIGINT, Recovered) - recover_Cases.Avg_recover, 2))/ COUNT(Recovered) AS Varience
 From ['Corona Virus Dataset$'],
 (SELECT AVG(CONVERT(BIGINT, Recovered)) AS Avg_recover FROM ['Corona Virus Dataset$']) AS recover_Cases;


 -- Q14. Find Country having highest number of the Confirmed case

 SELECT TOP 3 [Country/Region], MAX(confirmed) AS max_confirmed_cases
FROM ['Corona Virus Dataset$']
GROUP BY [Country/Region]
ORDER BY max_confirmed_cases DESC
 
 -- Q15. Find Country having lowest number of the death case
 
 SELECT TOP 3 [Country/Region], MAX(Deaths) AS min_Death_cases
FROM ['Corona Virus Dataset$']
GROUP BY [Country/Region]
ORDER BY min_Death_cases ASC


  -- Q16. Find top 5 countries having highest recovered case

  SELECT TOP 5 [Country/Region], MAX(Recovered) AS max_recovered_cases
FROM ['Corona Virus Dataset$']
GROUP BY [Country/Region]
ORDER BY max_recovered_cases DESC
