


CREATE view [dbo].[vw_WdImportExportByCountryAndTradeAverageUSD]
AS
WITH CTE_ImportCoutriesDestination(ImportingCountry, ImportCountriesCount, TotalImportsUSD)
AS(
	select  ImportingCountry, count(PartnerCountry) as ImportCountriesCount, SUM(ImportsTotalValueUSD) as TotalImportsUSD
	from vw_WdImportTradeServices 
	group by ImportingCountry
),
CTE_ExportCoutriesDestination(ExportingCountry, ExportCountriesCount, TotalExporsUSD)
AS
(
	select  ExportingCountry, count(PartnerCountry) as ExportCountriesCount, SUM(ExportsTotalValueUSD) AS TotalExporsUSD
	from vw_WdExportTradeServices 
	group by ExportingCountry
)
SELECT A.ImportingCountry as CountryCode, A.TotalImportsUSD/5 as AverageImportsUSD, B.TotalExporsUSD/5 as AverageExportsUSD,  (B.TotalExporsUSD - A.TotalImportsUSD)/5 AS ImportExportDelta
FROM CTE_ImportCoutriesDestination as A
	join CTE_ExportCoutriesDestination as B on A.ImportingCountry = B.ExportingCountry
