
CREATE VIEW vw_AfExportTechTradeServiceAverageUSD
AS
WITH CTE_AggregateTradeServices(ExportingCountry, ExportComodity, ExportsTotalValueUSD)
AS
(	SELECT 
		TS.[PartnerCountry] as ExportingCountry, 
		TS.[BOP] as ExportComodity, 
		Sum(TS.[ImportsValueUSD]) AS ExportsTotalValueUSD 
	FROM [dbo].[TradeInServices] AS TS
		join [dbo].[AfricanCountries] AS AC ON TS.[PartnerCountry] = AC.ISOCode3
	WHERE TS.[YEAR] >= 2007 AND [BOP] IN (
										 '245' --	3 Communications services
										,'247' --	3.2 Telecommunications services
										,'262' --	7 Computer and information services
										,'263' --	7.1 Computer services
										)
	GROUP BY TS.[PartnerCountry], TS.[BOP]
)
select ExportingCountry,  ExportComodity, ExportsTotalValueUSD/5 AS AverageExportsValueUSD
FROM CTE_AggregateTradeServices

