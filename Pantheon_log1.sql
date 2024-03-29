/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [acAppl]
      ,[anUserId]
      ,[adTime]
      ,[anHelpContext]
      ,[acType]
      ,[acSetOf]
      ,[acHostName]
      ,[acDatabaseName]
      ,[acValue]
      ,[acAutorization]
      ,[acDocType]
      ,[acCaption]
      ,[acOSUser]
      ,[acClassName]
      ,[acNavigatorValue]
      ,[acTreeListSelValue]
      ,[acEventDescr]
      ,[anQId]
      ,[anRevision]
      ,[acGUID]
      ,[anGroup]
      ,[acGroup]
      ,[acDatasetName]
      ,[acOwnerName]
      ,[adDuration]
      ,[adDurationTotal]
      ,[acParams]
      ,[anRecords]
      ,[anThreadId]
  FROM [PantheonFxAt].[dbo].[tPA_sysLogEvents]
  where achostname  like 'sre%' AND anUserId!=16
  ORDER BY ADTIME DESC


  SELECT DISTINCT ACHOSTNAME
  FROM [PantheonFxAt].[dbo].[tPA_sysLogEvents]
  where achostname NOT like 'CUR%' AND anUserId!=16
  ORDER BY ACHOSTNAME
  

