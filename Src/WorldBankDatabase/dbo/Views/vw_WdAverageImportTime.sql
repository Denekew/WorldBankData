

CREATE VIEW [dbo].[vw_WdAverageImportTime]
--Time to import, border compliance (hours)			IC.IMP.TMBC
--Time to import, documentary compliance (hours)	IC.IMP.TMDC
AS
With CTE_AnualImportHours(CountryName, CountryCode,	YR2014,	YR2015,	YR2016,	YR2017, YR2018)
AS
(
	SELECT MD.CountryName, 
			MD.CountryCode,
			SUM(CAST([2014] AS DECIMAL(18,0))) AS [YR2014], 	
			SUM(CAST([2015] AS DECIMAL(18,0))) AS [YR2015], 	
			SUM(CAST([2016] AS DECIMAL(18,0))) AS [YR2016], 	
			SUM(CAST([2017] AS DECIMAL(18,0))) AS [YR2017], 	
			SUM(CAST([2018] AS DECIMAL(18,0))) AS [YR2018] 
	FROM [WorldBank].[dbo].[MixedExtractData]  MD 
	where SeriesCode in ('IC.IMP.TMBC', 'IC.IMP.TMDC')
	group by MD.CountryName, MD.CountryCode
),
CTE_AverageAnnualImportTime(CountryName, CountryCode, AverageImportTime)
AS(
	select	CountryName,
			CountryCode,		
			CAST((YR2014 + YR2015 + YR2016 + YR2017  + YR2018)/5 AS DECIMAL(18,2)) AS  AverageImportTime
	From CTE_AnualImportHours
)
SELECT CountryName, CountryCode, AverageImportTime
FROM CTE_AverageAnnualImportTime
WHERE AverageImportTime is not null and AverageImportTime > 0 

