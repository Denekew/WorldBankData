﻿

CREATE VIEW [dbo].[vw_WdImportTradeServices]
AS
WITH CTE_AggregateTradeServices(ImportingCountry, PartnerCountry, ImportsTotalValueUSD)
AS
(	SELECT 
		TS.[ReportingCountry] as ImportingCountry, 
		TS.[PartnerCountry],
		Sum(TS.[ImportsValueUSD]) AS ImportsTotalValueUSD 
	FROM [dbo].[TradeInServices] AS TS
	WHERE TS.[YEAR] >= 2007
	GROUP BY TS.[ReportingCountry], TS.[PartnerCountry], TS.[BOP]
)
select ImportingCountry, PartnerCountry, ImportsTotalValueUSD
FROM CTE_AggregateTradeServices
