
CREATE VIEW [dbo].[vw_WdLaborForceAdvancedEducationWorkingAgePercent]
--Labor force with advanced education (% of total working-age population with advanced education)	SL.TLF.ADVN.ZS
AS
With CTE_AnnualLaborForcePercent(CountryName, CountryCode,	YR2014,	YR2015,	YR2016,	YR2017, YR2018)
AS
(
	SELECT MD.CountryName, 
			MD.CountryCode,
			CAST([2014] AS DECIMAL(18,14)) AS [YR2014], 	
			CAST([2015] AS DECIMAL(18,14)) AS [YR2015], 	
			CAST([2016] AS DECIMAL(18,14)) AS [YR2016], 	
			CAST([2017] AS DECIMAL(18,14)) AS [YR2017], 	
			CAST([2018] AS DECIMAL(18,14)) AS [YR2018] 
	FROM [WorldBank].[dbo].[MixedExtractData]  MD 
	where SeriesCode = 'SL.TLF.ADVN.ZS'	--High-technology exports (% of manufactured exports)	
),
CTE_MaximumLaborForcePercent(CountryName, CountryCode, MaxAdvEduLaborForcePercent)
AS(
	select CountryName,
		CountryCode,
		CASE
			WHEN YR2014 >= YR2015 AND YR2015 >= YR2016 AND YR2016 >= YR2017  AND YR2017 >= YR2018  THEN YR2014
			WHEN YR2015 >= YR2014 AND YR2015 >= YR2016 AND YR2015 >= YR2017  AND YR2015 >= YR2018  THEN YR2015
			WHEN YR2016 >= YR2014 AND YR2016 >= YR2015 AND YR2016 >= YR2017  AND YR2016 >= YR2018  THEN YR2016
			WHEN YR2017 >= YR2014 AND YR2017 >= YR2015 AND YR2017 >= YR2016  AND YR2017 >= YR2018  THEN YR2017
			WHEN YR2018 >= YR2014 AND YR2018 >= YR2015 AND YR2018 >= YR2016  AND YR2018 >= YR2017  THEN YR2018    
		   -- ELSE YR2014
		END AS MaxAdvEduLaborForcePercent
	From CTE_AnnualLaborForcePercent
)
SELECT CountryName, CountryCode, MaxAdvEduLaborForcePercent
FROM CTE_MaximumLaborForcePercent
WHERE MaxAdvEduLaborForcePercent is not null and MaxAdvEduLaborForcePercent > 0 

