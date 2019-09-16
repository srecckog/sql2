use feroapp
select r.id_radnika,r.ID_Fink,er.Radnik,napomena1,datumunosa,brojsati
from evidencijanormiradnici er
left join radnici r on r.id_radnika=er.ID_Radnika
where datumunosa='2017-03-20'
order by r.id_radnika

----------------------------------------

use feroapp
select er.*,'Dosao, upisano mu 0 sati' as NapomenaS,r.id_fink
from evidencijanormiradnici er
left join radnici r on r.id_radnika=er.id_radnika
left join [rfind].dbo.radnici_ r1 on r1.id=r.id_fink
where er.datumunosa= '2017-03-20'
and er.brojsati=0
and r.id_fink
in
(
select u.extid
from [RFIND].dbo.[user] u
left join [rfind].dbo.event e on e.[user]=u.oid
where CONVERT(VARCHAR(10), e.dt, 103)= '20/03/2017'
)

union all

select er.*,'Nije dosao, upisani mu sati' as NapomenaS,r.ID_Fink
from evidencijanormiradnici er
left join 
(
select id_radnika,id_fink,r.ime 
from radnici r
left join [rfind].dbo.radnici_ r1 on r1.id=r.id_fink
where r1.neradi=0
) r on r.id_radnika=er.id_radnika
where er.datumunosa= '2017-03-20'
and er.brojsati>0
and r.id_fink
not in
(
select u.extid
from [RFIND].dbo.[user] u
left join [rfind].dbo.event e on e.[user]=u.oid
where CONVERT(VARCHAR(10), e.dt, 103)= '20/03/2017'
--and u.extid=1315
)
order by datumunosa desc,vrijemeunosa



select *
from radnici
where ime like '%MIHALJEVIÆ%'


select *
from evidencijanormiradnici er
WHERE RADNIK LIKE '%mihaljeviæ kristi%'


