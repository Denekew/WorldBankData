create view AAFinalTradeServiceDataWithKwhForAnalysis
AS
select A.*, B.[GDPGrowthPercent], C.[LogisticsPerfIndex], D.[InsuranceAndFinancialSvcPercent], CAST(E.[MaxElectricProductionKwh]/100000 AS INT) AS ElectricProductionMwh
FROM [vw_ImportExportByCountryAndTradeAverageUSD] AS A
	join [dbo].[vw_AfGdpGrowthPercent] AS B ON A.CountryCode = B.[CountryCode]
	join [dbo].[vw_AfLogisticsPerformanceIndex] AS C ON A.CountryCode = C.[CountryCode]
	join [dbo].[vw_AfInsuranceAndFinancialServices] AS D ON A.CountryCode = D.[CountryCode]
	join [dbo].[vw_AfRenewableSourceElectricProductionKwh] AS E ON A.CountryCode = E.[CountryCode]