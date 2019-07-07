
CREATE VIEW vw_AfExportByComodityTradeAverageUSD
AS
WITH CTE_AggregateTradeServices(ExportingCountry, ExportComodity, ExportsTotalValueUSD)
AS
(	SELECT 
		TS.[PartnerCountry] as ExportingCountry, 
		TS.[BOP] as ExportComodity, 
		Sum(TS.[ImportsValueUSD]) AS ExportsTotalValueUSD 
	FROM [dbo].[TradeInServices] AS TS
		join [dbo].[AfricanCountries] AS AC ON TS.[PartnerCountry] = AC.ISOCode3
	WHERE TS.[YEAR] >= 2007
	GROUP BY TS.[PartnerCountry], TS.[BOP]
)
select ExportingCountry,  ExportComodity, ExportsTotalValueUSD/5 AS AverageExportsValueUSD
FROM CTE_AggregateTradeServices

