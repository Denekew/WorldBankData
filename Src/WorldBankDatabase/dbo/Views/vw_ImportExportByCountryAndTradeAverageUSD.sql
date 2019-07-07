
CREATE view [dbo].[vw_ImportExportByCountryAndTradeAverageUSD]
AS
WITH CTE_ImportCoutriesDestination(ImportingCountry, ImportCountriesCount, TotalImportsUSD)
AS(
	select  ImportingCountry, count(PartnerCountry) as ImportCountriesCount, SUM(ImportsTotalValueUSD) as TotalImportsUSD
	from vw_AfImportTradeServices 
	group by ImportingCountry
),
CTE_ExportCoutriesDestination(ExportingCountry, ExportCountriesCount, TotalExporsUSD)
AS
(
	select  ExportingCountry, count(PartnerCountry) as ExportCountriesCount, SUM(ExportsTotalValueUSD) AS TotalExporsUSD
	from vw_AfExportTradeServices 
	group by ExportingCountry
)
SELECT C.Country, A.ImportingCountry as CountryCode, A.TotalImportsUSD/5 as AverageImportsUSD, B.TotalExporsUSD/5 as AverageExportsUSD,  (B.TotalExporsUSD - A.TotalImportsUSD)/5 AS ImportExportDelta
FROM CTE_ImportCoutriesDestination as A
	join CTE_ExportCoutriesDestination as B on A.ImportingCountry = B.ExportingCountry
	join [dbo].[AfricanCountries] as C ON C.ISOCode3 = A.ImportingCountry
