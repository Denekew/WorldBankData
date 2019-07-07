CREATE VIEW vw_AfImportTechTradeServiceAverageUSD
AS
WITH CTE_AggregateTradeServices(ImportingCountry, ImportComodity, ImportsTotalValueUSD)
AS
(	SELECT 
		TS.[ReportingCountry] as ImportingCountry, 
		TS.[BOP] as ImportComodity, 
		Sum(TS.[ImportsValueUSD]) AS ImportsTotalValueUSD 
	FROM [dbo].[TradeInServices] AS TS
		join [dbo].[AfricanCountries] AS AC ON TS.[ReportingCountry] = AC.ISOCode3
	WHERE TS.[YEAR] >= 2007 AND [BOP] IN (
										 '245' --	3 Communications services
										,'247' --	3.2 Telecommunications services
										,'262' --	7 Computer and information services
										,'263' --	7.1 Computer services
										)
	GROUP BY  TS.[ReportingCountry], TS.[BOP]
)
select ImportingCountry,  ImportComodity, ImportsTotalValueUSD/5 AS AverageImportsValueUSD
FROM CTE_AggregateTradeServices

