select datum,hala,linija,smjena,brojrn,nazivpro,norma,kolicinaok,kupac
from evidnormi('2018-04-01','2018-04-19',0)
where id_pro='941273'



select e.datum,e.smjena,e.kolicinaok,e.brojrn,pn.*
from ProizvodneNorme pn
left join evidnormi('2018-04-01','2018-04-19',0) e on pn.id_pro=e.id_pro and pn.hala=e.hala and pn.linija=e.linija
where e.id_pro='941273' --e.norma=1 and pn.Norma=1
order by hala,linija


select *
from ProizvodneNorme
where id_pro='941273' and linija='22'