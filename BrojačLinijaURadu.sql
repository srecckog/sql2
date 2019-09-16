select distinct hala,linija,kupac
from evidnormi('2017-09-19','2017-09-19',0)
where linija not in ('GT600-1','GT600-2','VC510','EMAG','HURCO')
order by hala,linija