/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Idradnika]
      ,[idvjestine]
      ,[Vrijednost]
      ,[Firma]
      ,[idskolovanja]
  FROM [RFIND].[dbo].[RadniciVjestineS]
  
  delete from skolovanje where idradnika=277  
  delete from skolovanje1 where idradnika=277
  delete from radnicivjestines where idradnika=277
  delete from radnicivjestine where idradnika=277
  
  select *
  from skolovanje
  where idradnika=277

  select *
  from RadniciVjestine
  where idradnika=277
  order by idvjestine

  select *
  from RadniciVjestines
  where idradnika=277



