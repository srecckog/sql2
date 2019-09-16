declare @dat2 date='2018-08-28' -- datum uzimanja podataka
declare @mjes1 int=8
declare @godina1 int=2018

--select max(p.datum) datum ,idradnika,r.ID_Firme
--from [rfind].dbo.pregledvremena p
--left join [rfind].dbo.radnici8 r on r.id_fink=p.idradnika
----where p.datum<=DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0))
--where month(p.datum) = @mjes1 and year(p.datum)=@godina1 and (p.idradnika>8000 and p.idradnika<9000)
----where p.datum<=(getdate()-1) and (idradnika<8000 or idradnika>9000)
--group by p.idradnika,r.id_firme

use feroapp
delete from [feroapp].dbo.RadniciPlanZadnjiDan where month(datum)=@mjes1 and year(datum)=@godina1
insert into [feroapp].dbo.RadniciPlanZadnjiDan ( datum,id_radnika,smjena,id_firme,mjesec,godina)


select j.Datum , j.id_radnika ,p.Smjena, j.ID_Firme,@mjes1,@godina1--,j.ime,j.prezime,j.ime2,j.idradnika
from (
select max(p.datum) datum ,p.idradnika,r.ID_Firme,r.id_radnika,r.ime,r1.prezime,r1.ime ime2
from [rfind].dbo.pregledvremena p
left join [rfind].dbo.radnici_ r1 on r1.id=p.idradnika 
left join radnici r on r.id_radnika=r1.id_radnika 
--where p.datum<=DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0))
where month(p.datum) = @mjes1 and year(p.datum)=@godina1 and p.idradnika<9000
and p.radnomjesto not like 'OTKAZ%'
--where p.datum<=(getdate()-1) and (idradnika<8000 or idradnika>9000)
group by p.idradnika,r.id_firme,r.id_radnika,r.ime,r1.prezime,r1.ime
) j
left join [rfind].dbo.pregledvremena p on p.datum=j.datum and p.idradnika=j.idradnika
order by j.id_radnika

-----
--
declare @mjes1 int=8
declare @godina1 int=2018
update [feroapp].dbo.RadniciPlanZadnjiDan  set datum=x1.datum,id_radnika=x1.id_radnika,smjena=x1.smjena,id_firme=x1.id_firme,mjesec=x1.mjesec,godina=x1.godina
from
(
select j.Datum , j.id_radnika ,p.Smjena, j.ID_Firme,@mjes1 mjesec,@godina1 godina--,j.ime,j.prezime,j.ime2,j.idradnika
from (
select max(p.datum) datum ,p.idradnika,r.ID_Firme,r.id_radnika,r.ime,r1.prezime,r1.ime ime2
from [rfind].dbo.pregledvremena p
left join [rfind].dbo.radnici_ r1 on r1.id=p.idradnika 
left join radnici r on r.id_radnika=r1.id_radnika 
--where p.datum<=DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0))
where month(p.datum) = @mjes1 and year(p.datum)=@godina1 and p.idradnika<9000
and p.radnomjesto not like 'OTKAZ%'
--where p.datum<=(getdate()-1) and (idradnika<8000 or idradnika>9000)
group by p.idradnika,r.id_firme,r.id_radnika,r.ime,r1.prezime,r1.ime
) j
inner join [rfind].dbo.pregledvremena p on p.datum=j.datum and p.idradnika=j.idradnika

)x1
left join [feroapp].dbo.RadniciPlanZadnjiDan x2 on x2.id_radnika=x1.id_radnika








--select max(p.datum) datum ,(p.idradnika-8000) idradnika,r.ID_Firme,p.smjena
--from [rfind].dbo.pregledvremena p
--left join [rfind].dbo.radnici8 r on r.id_fink=p.idradnika
----where p.datum<=DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0))
--where month(p.datum) = 7 and year(p.datum)=2018 and (p.idradnika>8000 and p.idradnika<9000)
--group by p.idradnika,r.id_firme,p.smjena


--use rfind
--select *
--from pregledvremena
--where idradnika=1563
--order by datum desc


--select *
--from radnici
--where id_fink=1563



--select max(p.datum) datum ,p.idradnika,r.ID_Firme
--from [rfind].dbo.pregledvremena p
--left join [rfind].dbo.radnici_ r1 on r1.id=p.idradnika 
--left join radnici r on r.id_fink=p.idradnika 
----where p.datum<=DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0))
--where month(p.datum) = 8 and year(p.datum)=2018 
----where p.datum<=(getdate()-1) and (idradnika<8000 or idradnika>9000)
--group by p.idradnika,r.id_firme
--order by p.idradnika




--update [rfind].dbo.radnici_ set idradnika=j.id_radnika
--from (
--select max(p.datum) datum ,p.idradnika,r.ID_Firme,r.id_fink,r.id_radnika
--from [rfind].dbo.pregledvremena p
--left join [rfind].dbo.radnici_ r1 on r1.id=p.idradnika 
--left join radnici r on r.id_fink=p.idradnika 
----where p.datum<=DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0))
--where month(p.datum) >= 7 and year(p.datum)=2018 and r1.poduzece like 'Toka%' and r.id_firme!=2
----where p.datum<=(getdate()-1) and (idradnika<8000 or idradnika>9000)
--group by p.idradnika,r.id_firme,r.id_fink,r.id_radnika
--)j
--inner join [rfind].dbo.radnici_ r on r.id=j.id_fink