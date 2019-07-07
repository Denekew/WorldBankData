CREATE VIEW vw_AfImportByComodityTradeAverageUSD
AS
WITH CTE_AggregateTradeServices(ImportingCountry, ImportComodity, ImportsTotalValueUSD)
AS
(	SELECT 
		TS.[ReportingCountry] as ImportingCountry, 
		TS.[BOP] as ImportComodity, 
		Sum(TS.[ImportsValueUSD]) AS ImportsTotalValueUSD 
	FROM [dbo].[TradeInServices] AS TS
		join [dbo].[AfricanCountries] AS AC ON TS.[ReportingCountry] = AC.ISOCode3
	WHERE TS.[YEAR] >= 2007
	GROUP BY  TS.[ReportingCountry], TS.[BOP]
)
select ImportingCountry,  ImportComodity, ImportsTotalValueUSD/5 AS AverageImportsValueUSD
FROM CTE_AggregateTradeServices

