create view AAFinalTradeServiceDataForAnalysis
AS
select A.*, B.[GDPGrowthPercent], C.[LogisticsPerfIndex], D.[InsuranceAndFinancialSvcPercent] 
FROM [vw_ImportExportByCountryAndTradeAverageUSD] AS A
	join [dbo].[vw_AfGdpGrowthPercent] AS B ON A.CountryCode = B.[CountryCode]
	join [dbo].[vw_AfLogisticsPerformanceIndex] AS C ON A.CountryCode = C.[CountryCode]
	join [dbo].[vw_AfInsuranceAndFinancialServices] D ON A.CountryCode = D.[CountryCode]