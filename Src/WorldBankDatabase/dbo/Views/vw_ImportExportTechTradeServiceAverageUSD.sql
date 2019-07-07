Create view vw_ImportExportTechTradeServiceAverageUSD
AS
WITH CTE_ImportComodityDestination(ImportingCountry, ImportComodityCount, AverageComImportsValueUSD)
AS(
	select  ImportingCountry, count(ImportComodity) as ImportComodityCount, SUM(AverageImportsValueUSD) as AverageComImportsValueUSD
	from vw_AfImportTechTradeServiceAverageUSD 
	group by ImportingCountry
),
CTE_ExportComodityDestination(ExportingCountry, ExportComoditiesCount, AverageComExportsValueUSD)
AS
(
	select  ExportingCountry, count(ExportComodity) as ExportComoditiesCount, SUM(AverageExportsValueUSD) AS AverageComExportsValueUSD
	from vw_AfExportTechTradeServiceAverageUSD 
	group by ExportingCountry
)
SELECT C.Country, A.ImportingCountry, A.ImportComodityCount, A.AverageComImportsValueUSD/A.ImportComodityCount as AverageImportsValueUSD, B.ExportComoditiesCount, AverageComExportsValueUSD/B.ExportComoditiesCount as AverageExportsValueUSD
FROM CTE_ImportComodityDestination as A
	join CTE_ExportComodityDestination as B on A.ImportingCountry = B.ExportingCountry
	join [dbo].[AfricanCountries] as C ON C.ISOCode3 = A.ImportingCountry
