use fxapp
select DATUM,HALA,sum(kolicina) KOLICINA,linija
from ldp_aktivnost
where linija IN ('IDEALNO','realizirano','PLANIRANO')
and DATUM>'2017-04-01'
group by DATUM,HALA,linija
ORDER BY HALA,LINIJA


SELECT *
FROM ldp_aktivnost
where datum='2017-04-11'
and linija='19'
and hala=3


select *
from evidnopr