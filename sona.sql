use feroapp
select *
from evidnormi('2017-12-05','2017-12-05',0)
where gotovo>=0
and kupac like '%SONA%'
and Obradaa>=0
and linija='36'
order by hala,smjena,nazivpro


select hala,smjena,linija,sum(norma) norma,sum(kolicinaok) kolicina,kupac
from evidnormi('2017-12-05','2017-12-05',0)
where kupac like '%SONA%'
group by hala,smjena,linija,kupac
order by hala,smjena,linija,kupac


select sum(norma) norma,sum(kolicinaok) kolicina,kupac
select *
from evidnormi('2017-12-05','2017-12-05',0)
where kupac like '%SONA%'
and linija  IN ('GT600-1','GT600-2')
--and gotovo=0
--group by kupac
order by kupac


select datum,hala,smjena,NazivLinije,id_pro,brojrn,nazivpro,norma,kolicinaok,vrijemeod,vrijemedo
from evidnormi('2017-12-05','2017-12-05',0)
where kupac like '%SONA%'
--and linija='19'
order by hala,smjena,linija,kupac


select datum,hala,smjena,NazivLinije,id_pro,brojrn,nazivpro,norma,kolicinaok,VRIJEMEOD,VRIJEMEDO
from evidnormi('2017-12-05','2017-12-05',0)
where kupac like '%FERRO%'
order by hala,smjena,linija,kupac


select sum(norma),sum(kolicinaok)
from evidnormi('2017-12-06','2017-12-06',0)
where kupac like '%SONA%'
AND GOTOVO=1

order by hala,smjena,linija