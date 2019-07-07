CREATE PROC [dbo].[sp_AfAnnualValuesBySeriesCode]
(
	@SeriesCode Varchar(50)
)
AS
With CTE_AnnualValuePercent(CountryName, CountryCode,	YR2014,	YR2015,	YR2016,	YR2017, YR2018)
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
		JOIN [dbo].[AfricanCountries] A on MD.CountryCode = A.[ISOCode3]
	where SeriesCode = @SeriesCode	
),
CTE_MaximumValuePercent(CountryName, CountryCode, MaxValuePercent)
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
		END AS MaxValuePercent
	From CTE_AnnualValuePercent
)
SELECT CountryName, CountryCode, MaxValuePercent
FROM CTE_MaximumValuePercent
WHERE MaxValuePercent is not null and MaxValuePercent > 0 

