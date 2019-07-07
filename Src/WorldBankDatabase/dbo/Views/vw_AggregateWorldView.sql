
CREATE VIEW [dbo].[vw_AggregateWorldView]
AS
SELECT A.[CountryName]
	, A.[CountryCode]
	, A.[AverageEportTime]
	, B.[AverageImportTime]		
	, E.[LogisticsPerfIndex]
	, CASE
		WHEN G.[ElectricProductionKwh] IS NULL OR H.[ElectricProductionPercent] IS NULL THEN 0   
		ELSE CAST((G.[ElectricProductionKwh]/H.[ElectricProductionPercent])*100 AS DECIMAL(18,0))
	  END AS ElectricProductionKwh
	, F.[HighTechManufExportsPercent]
FROM [dbo].[vw_WdAverageEportTime] 							 AS A
	left JOIN [dbo].[vw_WdAverageImportTime]							 AS B ON A.CountryCode = B.CountryCode
	left JOIN [dbo].[vw_WdLogisticsPerformanceIndex]					 AS E ON A.CountryCode = E.CountryCode
	left JOIN [dbo].[vw_WdMedAndHighTechManufcturedExportsPercent]		 AS F ON A.CountryCode = F.CountryCode
	left JOIN [dbo].[vw_WdRenewableSourceElectricProductionKwh]		 AS G ON A.CountryCode = G.CountryCode
	left JOIN [dbo].[vw_WdRenewableSourceElectricProductionPercent]	 AS H ON A.CountryCode = H.CountryCode
where G.[ElectricProductionKwh] IS NOT NULL AND [HighTechManufExportsPercent] IS NOT NULL


