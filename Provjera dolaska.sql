 SELECT x2.lastname,x2.fxid,x2.dosao,x2.otisao,DATEDIFF(minute,x2.dosao,x2.otisao) as minuta,x2.mt,x2.rv 
 from ( select max(x1.dt) otisao , min(x1.dt) dosao , x1.lastname , x1.extid1 FxId,x1.mt,x1.rv from (  
 select e.no RFID_Hex,m.id mt,e.no2,dt,e.[User],e.Device_ID,r.name,LastName,u.FirstName,u.ExtId extid1,b.extid extid2,e.No2 serial_number,ri.rv 
 from event e  
 left join badge b on e.No= b.BadgeNo  
 left join [dbo].[User] u on u.extid=b.extid  
 left join eventtype t on e.EventType=t.Code  
 left join reader r on e.device_id=r.id 
 left join radnici_ ri on ri.id=u.extid 
 left join feroapp.dbo.radnici i on i.id_radnika=ri.id_radnika
 left join mjestotroska m on ri.mt=m.id  
 WHERE E.[USER] IS NOT NULL  and (dt >= '2019-05-13 0:00:00' AND dt<='2019-05-13 23:00:00') and (  EventType not in ('SP23','SP71') ) and u.ExtId=  1035
 AND r.door not in ( 7,8,9,10) ) x1  
 group by x1.lastname,x1.extid1,x1.mt,x1.rv ) x2


 SELECT r.prezime,r.ime,v.*
 FROM PREGLEDVREMENA v
 left join radnici_ r on r.id=v.idradnika
 WHERE IDRADNIKA=1035 and datum='2019-05-13'