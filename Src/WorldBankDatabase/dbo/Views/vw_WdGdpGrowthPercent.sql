
/****** Script for SelectTopNRows command from SSMS  ******/

Create view [dbo].[vw_WdGdpGrowthPercent]
AS
SELECT [CountryName]
      ,[CountryCode]
      ,[2018] as GDPGrowthPercent
  FROM [WorldBank].[dbo].[GlobalEconomicProspect] 
