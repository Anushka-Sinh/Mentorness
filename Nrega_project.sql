select * from NREGA$;

select count(*) AS NullCount from NREGA$ where state_name is null or 
  district_name is null or 
 [Total No# of JobCards issued]	 is null or
 [Total No# of Workers] is null ;

SELECT COUNT(*) AS Row_Count FROM NREGA$;

SELECT count(*)
FROM information_schema.columns
WHERE table_name = 'NREGA$';

select COLUMN_NAME from information_schema.columns where table_name = 'NREGA$';

----Q1. How effective is NREGA in providing employment opportunities to rural households?
SELECT 
  state_name,
  district_name,
  -- Employment opportunities metrics
  ([Total No# of Active Workers]/ [Total No# of Workers]) * 100 AS Employment_Rate,
  [Average days of employment provided per Household] AS Avg_Days_Employment,
  [Total No of HHs completed 100 Days of Wage Employment] AS HHs_100_Days_Employment,
  
  -- Demographic representation metrics
  ([SC workers against active workers] / [Total No# of Active Workers]) * 100 AS SC_Worker,
  ([ST workers against active workers] / [Total No# of Active Workers]) * 100 AS ST_Worker
FROM NREGA$
ORDER BY 
  Employment_Rate DESC;


---Q2. Are there regional disparities in the implementation and outcomes of the scheme?
---Q3. What is the utilization of the allocated budget, and how does it correlate with employment generation?
SELECT 
    state_name,
    district_name,
    COUNT([Total No# of JobCards issued]) AS TotalJobCardsIssued,
    SUM([Total No# of Active Workers]) AS TotalActiveWorkers,
    AVG([Average days of employment provided per Household]) AS AvgDaysOfEmployment,
    AVG([Average Wage rate per day per person(Rs#)]) AS AvgWageRate,
    SUM([Total Exp(Rs# in Lakhs#)]) AS TotalExpenditure,
    AVG([% of NRM Expenditure(Public + Individual)]) AS AvgNRMExpenditurePercentage,
    AVG([% of Category B Works]) AS AvgCategoryBWorksPercentage,
	SUM([Total Households Worked]) AS Avg_Total_Households_Worked,
	AVG([Approved Labour Budget]) AS Avg_Approved_Labour_Budget
FROM 
    NREGA$
GROUP BY 
    state_name,
    district_name
ORDER BY 
    state_name,
    district_name;



SELECT 
    state_name,
    district_name,
    AVG([Total No# of Works Takenup (New+Spill Over)]) AS Works_taken,
    AVG([% of Expenditure on Agriculture & Agriculture Allied Works]) AS Expenditure_Agriculture,
	AVG([Material and skilled Wages(Rs# In Lakhs)]) AS Material_and_skilled_Wages
FROM 
    NREGA$
GROUP BY 
    state_name,
    district_name
ORDER BY 
    state_name,
    district_name;






