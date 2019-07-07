
CREATE VIEW [dbo].[vw_AfAverageEportTime]
--Time to export, border compliance (hours)			IC.EXP.TMBC
--Time to export, documentary compliance (hours)	IC.EXP.TMDC
AS
With CTE_AnualExportHours(CountryName, CountryCode,	YR2014,	YR2015,	YR2016,	YR2017, YR2018)
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
		JOIN [dbo].[AfricanCountries] A on MD.CountryCode = A.[ISOCode3]
	where SeriesCode in ('IC.EXP.TMBC','IC.EXP.TMDC')--= 'TX.VAL.TECH.MF.ZS'	--High-technology exports (% of manufactured exports)	
	group by MD.CountryName, MD.CountryCode
),
CTE_AverageAnnualExportTime(CountryName, CountryCode, AverageEportTime)
AS(
	select	CountryName,
			CountryCode,		
			CAST((YR2014 + YR2015 + YR2016 + YR2017  + YR2018)/5 AS DECIMAL(18,2)) AS  AverageEportTime
	From CTE_AnualExportHours
)
SELECT CountryName, CountryCode, AverageEportTime
FROM CTE_AverageAnnualExportTime
WHERE AverageEportTime is not null and AverageEportTime > 0 

