/****** Script for SelectTopNRows command from SSMS  ******/
SELECT iv.*,P.NazivPar
  FROM [FeroApp].[dbo].[IzlazniDokumenti] id
  left join IzlazRobeDetaljnoView iv on iv.ID_IZD=id.ID_IZD
  left join Partneri P ON P.ID_Par=IV.ID_Par
  where id.BrojDokumenta like '2289%'