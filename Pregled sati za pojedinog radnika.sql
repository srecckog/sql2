/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [OID]
      ,[No]
      ,[No2]
      ,[Dt]
      ,[IsPaired]
      ,[User]
      ,[Device_ID]
      ,[EventType]
      ,[TnaEvent]
      ,[OptimisticLockField]
      ,[GCRecord]
  FROM [RFIND].[dbo].[Event]


  select *,datediff(minute,x1.usao,x1.izasao)
  from (
  select DAY(DT) dan,[USER] USER1,MAX(DT) izasao,MIN(DT) usao
  from event
  where month(dt)=5
  and evenTtype='SP39'
  and [user]='1242'
  GROUP BY DAY(DT),[USER]
  ) x1
  order by x1.user1
