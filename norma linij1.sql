select kupac,vrstanarudzbe,sum(norma) norma,'T' vo
from (

select kupac,vrstanarudzbe,sum(norma) norma,'T' vo
from evidnormi('2017-11-28','2017-11-28',0)
where linija  not in ('GT600-1','GT600-2','VC510','HURCO') 
GROUP BY KUPAC,vrstanarudzbe

union all

select kupac,vrstanarudzbe,sum(norma*-1) norma,'T' vo
from (
select count(*) broj,hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
from (
select hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
from evidnormi('2017-11-28','2017-11-28',0)
where linija  not in ('GT600-1','GT600-2','VC510','HURCO')
group by hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
) x1
group by hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
having count(*)=2 
) x2
GROUP BY KUPAC,vrstanarudzbe
) x3
group by kupac,vrstanarudzbe,vo

union all

select kupac,vrstanarudzbe,sum(norma),'DO' vo
from (
select kupac,vrstanarudzbe,sum(norma) norma,'DO' vo
from evidnormi('2017-11-28','2017-11-28',0)
where linija  in ('GT600-1','GT600-2','VC510','HURCO') 
GROUP BY KUPAC,vrstanarudzbe
union all
select kupac,vrstanarudzbe,sum(norma*-1) norma,'DO' vo
from (
select count(*) broj,hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
from (
select hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
from evidnormi('2017-11-28','2017-11-28',0)
where linija  in ('GT600-1','GT600-2','VC510','HURCO')
group by hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
) x1
group by hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
having count(*)=2 
) x2
GROUP BY KUPAC,vrstanarudzbe
) x3
group by kupac,vrstanarudzbe,vo
order by kupac
