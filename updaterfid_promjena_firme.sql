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

  -- update event
  use rfind
  update event set [user]=2593 where [user]=2442

  -- update badge
  select *
  from badge
  update badge set [user]=2597,extid=1498 where [user]=2597


  select *
  from badge where [user]=2457

  -- update pregled vremena
  update pregledvremena set idradnika=1498 where idradnika=66


  select *
  from [user]
  where extid=1339

  select *
  from event
  where [user]=2597  -- malović filip
    

  select *
  from badge where extid=1498

  
  select *
  from [user]
  where oid=2597

  use rfind
  select *
  from [user]
  where extid=1367

  select *
  from event
  where [user]=2457

  update [user] set extid=85 where oid=2426

    -- update badge
  select *
  from badge
  where [user]=2426

  update badge set extid=85 where [user]=2426

  update badge set extid=83 where [user]=2457

  update [user] set extid=84 where oid=2461


  update radnici_ set id=85 where id=1339
  update radnici_ set poduzece='Tokabu' where id=85

  select *
  from radnici_   where id=85

  select *
  from kompetencije
  where id=85 
  
  update kompetencije set id=85,poduzece='Tokabu' where id=1339
  update kompetencije set prezimeime='DRAGOŠA IVAN (85)' WHERE ID=85

  select *
  from pregledvremena
  where idradnika=85

  update PregledVremena set idradnika=85 where idradnika=1339