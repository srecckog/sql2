--use feroapp
--select * into ProizvodneNorme_old2
--from  proizvodnenorme
select *
from evidnormi('2019-03-07','2021-12-31',0)
where norma=1 and kolicinaok>0



use feroapp
select p.nazivpro,p.id_pro,n.*
from ProizvodneNorme N
LEFT JOIN PROIZVODI P on n.id_pro=p.id_pro
where n.ID_Pro ='951049' and hala=1 and linija='36*' --and linija like '%23%'

use feroapp
select p.nazivpro,p.id_pro,n.*
from ProizvodneNorme N
LEFT JOIN PROIZVODI P on n.id_pro=p.id_pro
where n.norma=1 and id_pro
in (


)


use feroapp
select p.nazivpro,p.id_pro,n.*
from ProizvodneNorme N
LEFT JOIN PROIZVODI P on n.id_pro=p.id_pro
where hala=1 and n.ID_Pro ='940076' and linija='14*'

--begin transaction
update proizvodnenorme set norma=360 where id_pro='940467' and hala=1 and linija='09' and norma=430 --  and id_mat='920577' and obradaa=1 -- and id_mat='920133' -- 1  scuric


--update proizvodnenorme set norma=325 where id_pro='940076' and hala=1 and linija='10' and norma=1   -- 1 is 


select * from proizvodnenorme where hala='1' and linija='09' and id_pro='940467'

select n.hala,n.linija,n.norma,p.*,n.*
from ProizvodneNorme N
LEFT JOIN PROIZVODI P on n.id_pro=p.id_pro
where p.id_pro='941614' AND LINIJA='28'
and hala=3


select *
from evidnormi('2018-1-01','2018-11-26',0)
where id_pro='941536'
order by datum


select *
from rfind.dbo.norme_log
where linija in ( '27','27*') and hala=3
order by datum desc

select * from proizvodnenorme where hala='3' and linija in ('28','28*') and id_pro='941614'


select * into rfind.dbo.proizvodnenorme
from feroapp.dbo.proizvodnenorme


select s.*
from  EvidencijaNormizag z
left join EvidencijaNormista s on s.ID_ENZ=z.ID_ENZ
where  hala=1 and datum='2019-08-29' and s.linija='09'

select * 
from  EvidencijaNormista
where  norma=430 and id_enz=18324 and linija='09'

UPDATE EvidencijaNormiSta set norma=360 where  norma=430 and id_enz=18324 and linija='09'