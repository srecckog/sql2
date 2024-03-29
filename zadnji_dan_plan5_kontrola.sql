declare @mjes1 int=8
declare @godina1 int=2018

select j.Datum , j.id_radnika ,p.Smjena, j.ID_Firme,j.ime,j.prezime rf_prezime,j.ime2 rf_ime,j.idradnika pv_idradnika
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

-----------------------
-- u planu je a ne radi više
----------------
select p.datum,p.idradnika,r.prezime,r.ime,r.DatumPrestanka,p.radnomjesto,r.poduzece
from [rfind].dbo.pregledvremena p
left join [rfind].dbo.radnici_ r on r.id=p.idradnika and datum>='2018-08-01'
where datum>datumprestanka --and datumprestanka<'2018-08-01'
order by datumprestanka
---------
select *
from [rfind].dbo.pregledvremena
where dosao=otisao
and year(dosao)!=1900
and datum>='2018-08-01' and datum<='2018-08-30'
order by datum