/****** Script for SelectTopNRows command from SSMS  ******/

Create view vw_AfGdpGrowthPercent
AS
SELECT [CountryName]
      ,[CountryCode]
      ,[2018] as GDPGrowthPercent
  FROM [WorldBank].[dbo].[GlobalEconomicProspect] MD 
		JOIN [dbo].[AfricanCountries] A on MD.CountryCode = A.[ISOCode3]
