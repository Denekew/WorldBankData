CREATE VIEW [vw_AfMedAndHighTechManufcturedExportsPercent]
AS
With CTE_AggregateExport(CountryName, CountryCode,	YR2014,	YR2015,	YR2016,	YR2017, YR2018)
AS
(
	SELECT MD.CountryName, 
			MD.CountryCode,
			CAST([2014] AS DECIMAL(18,10)) AS [YR2014], 	
			CAST([2015] AS DECIMAL(18,10)) AS [YR2015], 	
			CAST([2016] AS DECIMAL(18,10)) AS [YR2016], 	
			CAST([2017] AS DECIMAL(18,10)) AS [YR2017], 	
			CAST([2018] AS DECIMAL(18,10)) AS [YR2018] 
	FROM [WorldBank].[dbo].[MixedExtractData]  MD 
		JOIN [dbo].[AfricanCountries] A on MD.CountryCode = A.[ISOCode3]
	where SeriesCode  = 'TX.MNF.TECH.ZS.UN'	--Medium and high-tech exports (% manufactured exports)
),
CTE_MaximumExportPercent(CountryName, CountryCode, MaxEport)
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
		END AS MaxEport
	From CTE_AggregateExport
)
SELECT CountryName, CountryCode, MaxEport
FROM CTE_MaximumExportPercent
WHERE MaxEport is not null and MaxEport > 0 