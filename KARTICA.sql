USE RFIND
select dt Vrijeme,LastName Prezime,u.FirstName Ime,r.name Lokacija,e.Device_ID Uredaj,e.EventType,t.CodeName,b.extid FxId,e.[User],e.No2 Serial_number,e.no RFID_Hex 
from event e 
left join badge b on e.No= b.BadgeNo 
left join [dbo].[User] u on u.extid=b.extid 
left join eventtype t on e.EventType=t.Code 
left join reader r on r.id=e.device_id 
WHERE E.[USER] IS NOT NULL and e.eventtype!='SP23'  
and ( e.dt>='2017-10-25' and e.dt<='2017-10-26 23:59:59.00') 
AND (lastname+' '+firstname) like '%ŠPIŠ%' 


SELECT *
FROM EVENT
WHERE [USER]=915
ORDER BY DT DESC

SELECT *
FROM EVENT
WHERE NO='004AC3B'

SELECT *
FROM BADGE
WHERE EXTID=78

UPDATE BADGE SET EXTID=8078 WHERE [USER]=915


WHERE BADGENO='004AC3B'


