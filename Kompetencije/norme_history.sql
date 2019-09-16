use feroapp
select l.id_pro,l.norma,k.id_pro,k.norma,k.hala,k.linija
from evidnormi('2017-05-15','2017-05-15',0) l
left join evidnormi('2017-05-16','2017-05-16',0) k on l.id_pro=k.id_pro
where l.norma!=k.norma and l.hala=k.hala and k.linija=l.linija

--where id_pro='940153'


use feroapp
select *
from evidnormi('2017-04-01','2017-04-30',0)
