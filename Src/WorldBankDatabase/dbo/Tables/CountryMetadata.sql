CREATE TABLE [dbo].[CountryMetadata] (
    [CountryCode]  NVARCHAR (10)   NOT NULL,
    [CountryName]  NVARCHAR (100)  NOT NULL,
    [Region]       NVARCHAR (50)   NULL,
    [IncomeGroup]  NVARCHAR (50)   NULL,
    [SpecialNotes] NVARCHAR (1300) NULL
);

