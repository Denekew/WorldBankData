
CREATE VIEW [dbo].[vw_AggregateAfricanView]
AS
SELECT A.[CountryName]
	, A.[CountryCode]
	, A.[AverageEportTime]
	, B.[AverageImportTime]		
	, E.[LogisticsPerfIndex]
	, CASE
		WHEN G.[MaxElectricProductionKwh] IS NULL OR H.[MaxElectricProductionPercent] IS NULL THEN 0   
		ELSE CAST((G.[MaxElectricProductionKwh]/H.[MaxElectricProductionPercent])*100 AS DECIMAL(18,0))
	END AS ElectricProductionKwh
	, F.[MaxEport] AS MedAndHighTechExport
FROM [dbo].[vw_AfAverageEportTime] 							 AS A
	left JOIN [dbo].[vw_AfAverageImportTime]							 AS B ON A.CountryCode = B.CountryCode
	left JOIN [dbo].[vw_AfLogisticsPerformanceIndex]					 AS E ON A.CountryCode = E.CountryCode
	left JOIN [dbo].[vw_AfMedAndHighTechManufcturedExportsPercent]		 AS F ON A.CountryCode = F.CountryCode
	left JOIN [dbo].[vw_AfRenewableSourceElectricProductionKwh]		 AS G ON A.CountryCode = G.CountryCode
	left JOIN [dbo].[vw_AfRenewableSourceElectricProductionPercent]	 AS H ON A.CountryCode = H.CountryCode
where G.[MaxElectricProductionKwh] IS NOT NULL AND F.[MaxEport] IS NOT NULL

