
CREATE VIEW [dbo].[vw_WdExportTradeServices]
AS
WITH CTE_AggregateTradeServices(ExportingCountry, PartnerCountry, ExportsTotalValueUSD)
AS
(	SELECT 
		TS.[PartnerCountry] as ExportingCountry, 
		TS.[ReportingCountry] as PartnerCountry,
		Sum(TS.[ImportsValueUSD]) AS ExportsTotalValueUSD 
	FROM [dbo].[TradeInServices] AS TS
	WHERE TS.[YEAR] >= 2007
	GROUP BY TS.[PartnerCountry], TS.[ReportingCountry]
)
select ExportingCountry, PartnerCountry, ExportsTotalValueUSD
FROM CTE_AggregateTradeServices
