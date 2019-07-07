CREATE view vw_EthiopianRemittance
As

with CTE_BXTRFPWKRCDDT([CountryName], [Year], [BX.TRF.PWKR.CD.DT])
AS
(
	select [CountryName], [Year], [BX.TRF.PWKR.CD.DT]--, [BM.TRF.PWKR.CD.DT], [BX.TRF.PWKR.DT.GD.ZS] 
	from ( 
		select * from [dbo].[CountryConsumption]
		where [IndicatorCode] = 'BX.TRF.PWKR.CD.DT' and [CountryName] = 'Ethiopia' 
	) AS T
	--where [IndicatorCode] in  ('BX.TRF.PWKR.CD.DT', 'BM.TRF.PWKR.CD.DT', 'BX.TRF.PWKR.DT.GD.ZS') and [CountryName] = 'Ethiopia'
	UNPIVOT
	(
			[BX.TRF.PWKR.CD.DT]--, [BM.TRF.PWKR.CD.DT], [BX.TRF.PWKR.DT.GD.ZS]
			FOR [Year] IN ([1960], [1961], [1962], [1963], [1964], [1965], [1966], [1967], [1968], [1969], [1970], [1971], [1972], [1973], [1974], [1975], [1976], [1977], [1978], [1979], [1980], [1981], [1982], [1983], [1984], [1985], [1986], [1987], [1988], [1989], [1990], [1991], [1992], [1993], [1994], [1995], [1996], [1997], [1998], [1999], [2000], [2001], [2002], [2003], [2004], [2005], [2006], [2007], [2008], [2009], [2010], [2011], [2012], [2013], [2014], [2015], [2016], [2017], [2018], [2019])
	) AS P 
),
CTE_BMTRFPWKRCDDT([CountryName], [Year], [BM.TRF.PWKR.CD.DT])
AS
(
	select [CountryName], [Year], [BM.TRF.PWKR.CD.DT]--, [BM.TRF.PWKR.CD.DT], [BX.TRF.PWKR.DT.GD.ZS] 
	from ( 
		select * from [dbo].[CountryConsumption]
		where [IndicatorCode] = 'BM.TRF.PWKR.CD.DT' and [CountryName] = 'Ethiopia' 
	) AS T
	--where [IndicatorCode] in  ('BX.TRF.PWKR.CD.DT', 'BM.TRF.PWKR.CD.DT', 'BX.TRF.PWKR.DT.GD.ZS') and [CountryName] = 'Ethiopia'
	UNPIVOT
	(
			[BM.TRF.PWKR.CD.DT]--, [BM.TRF.PWKR.CD.DT], [BX.TRF.PWKR.DT.GD.ZS]
			FOR [Year] IN ([1960], [1961], [1962], [1963], [1964], [1965], [1966], [1967], [1968], [1969], [1970], [1971], [1972], [1973], [1974], [1975], [1976], [1977], [1978], [1979], [1980], [1981], [1982], [1983], [1984], [1985], [1986], [1987], [1988], [1989], [1990], [1991], [1992], [1993], [1994], [1995], [1996], [1997], [1998], [1999], [2000], [2001], [2002], [2003], [2004], [2005], [2006], [2007], [2008], [2009], [2010], [2011], [2012], [2013], [2014], [2015], [2016], [2017], [2018], [2019])
	) AS P 
	union
	select 'Ethiopia', '2018', '0'
),
CTE_BXTRFPWKRDTGDZS([CountryName], [Year], [BX.TRF.PWKR.DT.GD.ZS])
AS
(
	select [CountryName], [Year], [BX.TRF.PWKR.DT.GD.ZS]--, [BM.TRF.PWKR.CD.DT], [BX.TRF.PWKR.DT.GD.ZS] 
	from ( 
		select * from [dbo].[CountryConsumption]
		where [IndicatorCode] = 'BX.TRF.PWKR.DT.GD.ZS' and [CountryName] = 'Ethiopia' 
	) AS T
	--where [IndicatorCode] in  ('BX.TRF.PWKR.CD.DT', 'BM.TRF.PWKR.CD.DT', 'BX.TRF.PWKR.DT.GD.ZS') and [CountryName] = 'Ethiopia'
	UNPIVOT
	(
			[BX.TRF.PWKR.DT.GD.ZS]--, [BM.TRF.PWKR.CD.DT], [BX.TRF.PWKR.DT.GD.ZS]
			FOR [Year] IN ([1960], [1961], [1962], [1963], [1964], [1965], [1966], [1967], [1968], [1969], [1970], [1971], [1972], [1973], [1974], [1975], [1976], [1977], [1978], [1979], [1980], [1981], [1982], [1983], [1984], [1985], [1986], [1987], [1988], [1989], [1990], [1991], [1992], [1993], [1994], [1995], [1996], [1997], [1998], [1999], [2000], [2001], [2002], [2003], [2004], [2005], [2006], [2007], [2008], [2009], [2010], [2011], [2012], [2013], [2014], [2015], [2016], [2017], [2018], [2019])
	) AS P
)
select 
	t1.[CountryName] as Country
	, t1.[Year]
	, t1.[BX.TRF.PWKR.CD.DT] as RemittancesReceived
	, t2.[BM.TRF.PWKR.CD.DT] as RemittancesPaid
	, t3.[BX.TRF.PWKR.DT.GD.ZS]  as RemittancesReceivedPercentOfGDP
FROM CTE_BXTRFPWKRCDDT as t1
	inner join CTE_BMTRFPWKRCDDT as t2 on t1.[Year] = t2.[Year]
	inner join CTE_BXTRFPWKRDTGDZS as t3  On t1.[Year] = t3.[Year]



	--select * from vw_EthiopianRemittance