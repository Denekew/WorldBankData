CREATE TABLE [dbo].[TradeInServices] (
    [ReportingCountry]  NVARCHAR (50)  NOT NULL,
    [PartnerCountry]    NVARCHAR (50)  NOT NULL,
    [YEAR]              INT            NOT NULL,
    [BOP]               INT            NOT NULL,
    [ImportsValueUSD]   FLOAT (53)     NOT NULL,
    [SectorDescription] NVARCHAR (100) NOT NULL,
    [SectorName]        NVARCHAR (100) NOT NULL
);

