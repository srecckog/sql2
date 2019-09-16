
select hala,kupac,vrstanarudzbe,count(*) broj_linija
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( '2018-01-23', '2018-01-23' , 0 )
where  obrada3=0 and KolicinaOK > 0
and linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
group by hala,kupac,vrstanarudzbe
order by kupac




select distinct kupac,hala,smjena,linija,norma,kolicinaok,VrstaNarudzbe
from feroapp.dbo.evidnormi( '2018-01-23', '2018-01-23' , 0 )
order by linija


select distinct x1.naziv,x1.hala
from (
select p.naziv,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( '2018-01-23', '2018-01-23' , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Linija' and (e.kolicinaOK = 0 or e.kolicinaok is null)
) x1
--where x1.hala is null
order by x1.naziv

-- linije nisu uopæe radile
select distinct x1.naziv,x1.halal,x1.hala,x1.kupac,x1.id_par
from (
select p.naziv,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( '2018-01-23', '2018-01-23' , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Linija' 
) x1
where x1.hala is null
order by x1.hala,x1.naziv,x1.kupac,x1.id_par


-- linije koje nisu radile
select distinct x1.naziv,x1.halal,x1.hala,x1.kupac,x1.id_par
from (
select p.naziv,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( '2018-01-23', '2018-01-23' , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Linija' and e.kolicinaok=0
) x1
--where x1.hala is null
order by x1.hala,x1.naziv,x1.kupac,x1.id_par


-- linije sve, i duplikati ( dijeljene linije) 
select distinct x1.naziv,x1.halal,x1.hala,x1.kupac,x1.id_par
from (
select p.naziv,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( '2018-01-23', '2018-01-23' , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Linija' 
) x1
--where x1.hala is null
order by x1.hala,x1.naziv,x1.kupac,x1.id_par




select count(*),xx.Naziv,xx.hala
from (
select distinct x1.naziv,x1.halal,x1.hala,x1.kupac,x1.VrstaNarudzbe
from (
select p.naziv,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( '2018-01-25', '2018-01-25' , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Linija' 
) x1
) xx
group by xx.hala,xx.naziv
having count(*)>1
order by xx.hala,xx.naziv



where  obrada3=0 and KolicinaOK > 0
and linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')



select p.*
from feroapp.dbo.proizvodnelinije p
where hala='3' and vrsta='Linija'