/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Datum]
      ,[ID_kupac]
      ,[Kupac]
      ,[Kolicina_TOK]
      ,[Kolicina_DO]
      ,[Vrijednost_TOK]
      ,[Vrijednost_DO]
      ,[CT]
      ,[CM]
      ,[CG]
      ,[DatumUnosa]
  FROM [RFIND].[dbo].[DPR1]


 -- drop table dpr1

  use rfind

  insert into dpr1 (datum,id_kupac,kolicina_tok,kolicina_do,vrijednost_tok,vrijednost_do,datumunosa) 
  
  select datum,id_kupac,kolicina_tok,kolicina_do,vrijednost_tok,vrijednost_do,datumunosa
  from dpr

   