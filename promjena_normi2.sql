use feroapp
select *
from narudzbesta
where brojrn='NSK/135/18'


SELECT distinct p.*
FROM  PROizvodnenorme p
inner  join evidnormi('2018-08-01','2018-08-29',0) E on p.ID_PRO=E.ID_PRO AND P.hala=e.hala and p.linija=e.linija
where E.id_pro='941421' and p.hala=3 and p.linija='28'
 and	p.obradaa=e.obradaa and  p.obradab=e.obradab and p.obradac=e.obradac and  p.obradad=e.obradad 
and e.BrojRN='NSK/135/18'

select *
from evidencijasta



select *
from evidnormi('2018-08-01','2018-08-29',0)
where hala=3 and linija='28' and brojrn='NSK/135/18' 

