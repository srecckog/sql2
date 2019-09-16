
  SELECT x2.lastname,x2.firstname,x2.fxid,x2.dosao,x2.otisao,DATEDIFF(minute,x2.dosao,x2.otisao) as minuta,x2.mt,x2.rv ,x2.datum1
  from (
  select max(x1.dt) otisao , min(x1.dt) dosao , x1.lastname , x1.firstname,x1.extid1 FxId,x1.mt,x1.rv , datum1
  from (  
  select e.no RFID_Hex,m.id mt,e.no2,dt,e.[User],e.Device_ID,r.name,LastName,u.FirstName,u.ExtId extid1,b.extid extid2,e.No2 serial_number,ri.rv  ,(year(dt)*100+month(dt)+day(dt)) as datum1
  from event e  
  left join badge b on e.No= b.BadgeNo  
  left join [dbo].[User] u on u.extid=b.extid  
  left join eventtype t on e.EventType=t.Code  
  left join reader r on e.device_id=r.id 
  left join radnici_ ri on ri.id=u.extid 
  left join mjestotroska m on ri.mt=m.id  
  WHERE E.[USER] IS NOT NULL  and (dt >= '2018-03-01' AND dt<='2018-03-31 23:59:00') and (  EventType not in ('SP23','SP71') ) 
  and r.door not in ( 17,18,19,110)   
  ) x1 
  group by x1.lastname,x1.firstname,x1.extid1,x1.mt,x1.rv,x1.datum1
  ) x2

left join 
(
  SELECT x2.lastname,x2.firstname,x2.fxid,x2.dosao,x2.otisao,DATEDIFF(minute,x2.dosao,x2.otisao) as minuta,x2.mt,x2.rv ,x2.datum1
  from (
  select max(x1.dt) otisao , min(x1.dt) dosao , x1.lastname , x1.firstname,x1.extid1 FxId,x1.mt,x1.rv , datum1
  from (  
  select e.no RFID_Hex,m.id mt,e.no2,dt,e.[User],e.Device_ID,r.name,LastName,u.FirstName,u.ExtId extid1,b.extid extid2,e.No2 serial_number,ri.rv  ,(year(dt)*100+month(dt)+day(dt)) as datum1
  from event e  
  left join badge b on e.No= b.BadgeNo  
  left join [dbo].[User] u on u.extid=b.extid  
  left join eventtype t on e.EventType=t.Code  
  left join reader r on e.device_id=r.id 

  left join radnici_ ri on ri.id=u.extid 
  left join mjestotroska m on ri.mt=m.id  
  WHERE E.[USER] IS NOT NULL  and (dt >= '2018-03-01' AND dt<='2018-03-31 23:59:00') and (  EventType not in ('SP23','SP71') ) 
  and r.door not in ( 7,8,9,10)   
  ) x1 
  group by x1.lastname,x1.firstname,x1.extid1,x1.mt,x1.rv,x1.datum1) x2
  --where x2.dosao=x2.otisao and year(x2.dosao)!=1900 
) x22 on x22.fxid=x2.fxid and x22.datum1=x2.datum1
where x22.otisao=x22.dosao and year(x22.dosao)!=1900 



