/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [BadgeNo]
      ,[CustomCardId]
      ,[Description]
      ,[ExtId]
      ,[Active]
      ,[User]
      ,[DtStart]
      ,[DtExpiry]
      ,[Sync]
      ,[OptimisticLockField]
      ,[GCRecord]
  FROM [RFIND].[dbo].[Badge]
  ORDER BY DTSTART