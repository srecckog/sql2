/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [BadgeNo]
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






  select *
  from event
order by dt desc