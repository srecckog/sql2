/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Rbroj]
      ,[IDRadnika]
      ,[Datum]
      ,[Dosao]
      ,[Otisao]
      ,[tdoci]
      ,[totici]
      ,[Checker]
      ,[Napomena]
      ,[Kasni]
      ,[Prekovremeni]
      ,[OdobreniPrekovremeni]
      ,[RazlogIzostanka]
      ,[Poduzece]
      ,[Smjena]
      ,[RadnoMjesto]
      ,[Hala]
      ,[Ukupno_sati]
      ,[Ukupno_minuta]
      ,[PreranoOtisao]
      ,[DatumUpisa]
  FROM [RFIND].[dbo].[PregledVremena]


  select * into pregledvremena1311
  from pregledvremena

  update pregledvremena set idradnika=1487 where idradnika=73
