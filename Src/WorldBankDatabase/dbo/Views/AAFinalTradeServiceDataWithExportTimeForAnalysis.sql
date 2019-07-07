create view AAFinalTradeServiceDataWithExportTimeForAnalysis
AS
select A.*, 
	B.[GDPGrowthPercent], 
	C.[LogisticsPerfIndex], 
	D.[InsuranceAndFinancialSvcPercent], 
	F.[AverageEportTime]
FROM [vw_WdImportExportByCountryAndTradeAverageUSD] AS A
	join [dbo].[vw_WdGdpGrowthPercent] AS B ON A.CountryCode = B.[CountryCode]
	join [dbo].[vw_WdLogisticsPerformanceIndex] AS C ON A.CountryCode = C.[CountryCode]
	join [dbo].[vw_WdInsuranceAndFinancialServices] AS D ON A.CountryCode = D.[CountryCode]	
	join [dbo].[vw_AfAverageEportTime] AS F ON A.CountryCode = F.[CountryCode]