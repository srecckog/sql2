/****** Script for SelectTopNRows command from SSMS  ******/
SELECT id,
		(prezime+' '+ime) prezimeime
      ,[poduzece]
      ,[preostaloDana]
  FROM [RFIND].[dbo].[GO_TKB]