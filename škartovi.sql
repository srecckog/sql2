

select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( '2017-08-03' , '2017-08-03' , 0 )
where kupac like '%Austria%' 
group by kupac,VrstaNarudzbe,turm
union all
-- SONA
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( '2017-08-03' , '2017-08-03' , 0 )
where  kupac LIKE '%SONA%' 
group by kupac,VrstaNarudzbe,turm
union all
-- Brasil
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( '2017-08-03' , '2017-08-03' , 0 )
where  kupac LIKE '%Brasil%' 
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Romania
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( '2017-08-03' , '2017-08-03' , 0 )
where  kupac LIKE '%Romania%' 
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Schaeffler Technologies, prsteni
select kupac+' Prsteni',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( '2017-08-03' , '2017-08-03' , 0 )
where  kupac LIKE '%Technolo%'  and VrstaNarudzbe like '%prsteni%'
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Schaeffler Technologies, valjci
select kupac+' Valjci',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( '2017-08-03' , '2017-08-03' , 0 )
where  kupac LIKE '%Technolo%' and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%'
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- ostali
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( '2017-08-03' , '2017-08-03' , 0 )
where gotovo=1 and  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%'AND KUPAC NOT LIKE '%Brasil%'
group by kupac,VrstaNarudzbe,turm