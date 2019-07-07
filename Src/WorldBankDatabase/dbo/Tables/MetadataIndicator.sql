CREATE TABLE [dbo].[MetadataIndicator] (
    [IndicatorCode]      NVARCHAR (50)   NOT NULL,
    [IndicatorName]      NVARCHAR (100)  NOT NULL,
    [SourceNote]         NVARCHAR (1250) NOT NULL,
    [SourceOrganization] NVARCHAR (400)  NOT NULL,
    [ExtraDetail]        NVARCHAR (1)    NULL
);

