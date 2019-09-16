  select max(x1.dt) otisao,min(x1.dt) dosao,convert(varchar,datepart(day,x1.dt))+'-'+convert(varchar,datepart(month,x1.dt) ) dan ,x1.lastname
  from (
  select e.no RFID_Hex,e.no2,dt,e.[User],e.Device_ID,r.name,e.EventType,LastName,u.FirstName,t.CodeName,u.ExtId extid1,b.extid extid2,e.No2 serial_number
  from event e
  left join badge b on e.No= b.BadgeNo
  left join [dbo].[User] u on u.extid=b.extid
  left join eventtype t on e.EventType=t.Code
  left join reader r on e.device_id=r.id
  WHERE E.[USER] IS NOT NULL
 ) x1
 group by convert(varchar,datepart(day,x1.dt))+'-'+convert(varchar,datepart(month,x1.dt) ),x1.lastname



  where u.LastName like '%GA%'



