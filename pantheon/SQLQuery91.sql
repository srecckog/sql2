/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[datum]
      ,[hala]
      ,[linija]
      ,[smjena]
      ,[proizvod]
      ,[norma]
      ,[max]
      ,[cijena]
      ,[kolicina]
      ,[iznos]
      ,[norma_iznos]
      ,[radnik]
      ,[ID_Partner]
      ,[kvarovi]
      ,[kvarovi_vrijeme]
      ,[bolovanja]
      ,[materijal]
      ,[alati]
      ,[izostanci]
      ,[stelanja]
      ,[stelanja_vrijeme]
      ,[Norma-stelanja]
      ,[Mjesec]
      ,[prebacaj]
      ,[podbacaj]
      ,[podbacaj_kolicina]
      ,[prebacaj_kolicina]
      ,[materijal_iznos]
      ,[Broj_Stelanja]
      ,[Broj_Kvarova]
      ,[Zadnji_Tjedan]
      ,[Zadnji_Mjesec]
      ,[Zadnja_Godina]
      ,[Tjedan]
      ,[Jucer]
      ,[HLinija]
      ,[PARTNER]
      ,[idealno]
      ,[OEE]
      ,[Cilj_OEE]
      ,[PARTNER2]
      ,[kupac]
      ,[skart_obrada]
      ,[skart_materijal]
      ,[TURM]
      ,[SK_MAT_TURM]
      ,[SK_MAT_SINGLE]
      ,[SK_OBR_TURM]
      ,[SK_OBR_SINGLE]
      ,[UKUPNO_SINGLE]
      ,[UKUPNO_TURM]
      ,[norma_iznos2]
      ,[norma8_kol]
      ,[norma8_EUR]
      ,[norma_85]
      ,[norma8_75]
      ,[norma8iznos]
      ,[norma_85iznos]
      ,[norma8_75iznos]
      ,[pausal]
  FROM [FxApp].[dbo].[ldp_aktivnost_view]


  select avg ((kolicina+0.01)/(norma+0.01) )
  

  SELECT  avg(kolicina/[MAX]+0.01) norma_posto,CAST( YEAR(DATUM) as varchar(4))+'-'+cast( MONTH(DATUM) as varchar(2)) period
  from ldp_aktivnost_view
  where month(datum)=3 and year(datum)=2017
 and radnik like '%GAŠPARIĆ%'
  and norma>0 AND KOLICINA>0
  group by CAST( YEAR(DATUM) as varchar(4))+'-'+cast( MONTH(DATUM) as varchar(2))
  


select kolicina , max , norma , datum , CAST( YEAR(DATUM) as varchar(4))+'-'+cast( MONTH(DATUM) as varchar(2)) period
from ldp_aktivnost_view
where month(datum)=3 and year(datum)=2017
and radnik like '%GAŠPARIĆ%'
and norma>0 AND KOLICINA>0
order by datum




  group by CAST( YEAR(DATUM) as varchar(4))+'-'+cast( MONTH(DATUM) as varchar(2))

