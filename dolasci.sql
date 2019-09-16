  --update pregledvremenaa where idradnika in 
  
  (
  SELECT x2.lastname,x2.firstname,x2.fxid,x2.dosao,x2.otisao,DATEDIFF(minute,x2.dosao,x2.otisao) as minuta,x2.mt,x2.rv 
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
  group by x1.lastname,x1.firstname,x1.extid1,x1.mt,x1.rv,x1.datum1
  
  ) x2
  where x2.dosao=x2.otisao


  ) 


 --update pregledvremena set dosao='2018-03-14 05:48',ukupno_minuta=493 where idradnika=1292 and datum='2018-03-14'--



 select r.id,r.prezime,r.ime,pv.*
 from pregledvremena pv
 left join radnici_ r on r.id=pv.idradnika
 where dosao=otisao 
 and datum>='2018-03-01' and datum<='2018-03-31'
 and year(dosao)!=1900
 and idradnika in ( 282,1292,1504,1260,940,1361,1440,814)
 order by r.prezime,datum


 select *
 from pregledvremena
 where idradnika=282 and datum>='2018-03-01' and datum<='2018-03-31'
 and ukupno_minuta<20


 and dosao=otisao
 order by datum

 --delete from pregledvremena where idradnika=814 and datum='2018-03-18'
 update pregledvremena set otisao='2018-03-31 04:04' where idradnika=282 and datum='2018-03-30' and tdoci=22
 update pregledvremena set otisao='2018-03-26 21:35' where idradnika=282 and datum='2018-03-26' and tdoci=22
 update pregledvremena set otisao='2018-03-14 21:15' where idradnika=282 and datum='2018-03-14' and tdoci=14

 update pregledvremena set Ukupno_minuta=datediff(n,dosao,otisao) where idradnika=282 and datum>='2018-03-03' and datum<='2018-03-31'

 --delete from pregledvremena where idradnika=1440 and datum='2018-04-02' and tdoci=14