select kupac,vrstanarudzbe,count(*) broj_stelanja
from feroapp.dbo.evidnormi( '2017-08-07', '2017-08-07' , 0 )
where tekstcheck01=1 and kupac like '%Austria%' 
group by kupac,VrstaNarudzbe


select *
from feroapp.dbo.evidnormi( '2017-08-07', '2017-08-07' , 0 )
where tekstcheck01=1 and kupac like '%Austria%' 
order by kupac,VrstaNarudzbe,VrijemeOdTC01,VrijemeDoTC01


select datum,hala,smjena,nazivlinije,id_pro,nazivpro,brojrn,kolicinaok,zavrsnaobrada,gotovo,vrijemeod,vrijemedo,vrijemeodtc01,vrijemedotc01
from feroapp.dbo.evidnormi( '2017-08-07', '2017-08-07' , 0 )
where tekstcheck01=1 and kupac like '%Austria%' 
order by kupac,hala,linija,VrstaNarudzbe,VrijemeOdTC01,VrijemeDoTC01


select kupac,vrstanarudzbe,count(*) broj_stelanja
from feroapp.dbo.evidnormi( '2017-08-07', '2017-08-07' , 0 )
where tekstcheck01=1 and 
group by kupac,VrstaNarudzbe




begin 
select kupac,VrstaNarudzbe, sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost, sum(kolicinaok) kolicinaok, (select count(*)  from ( select BrojRN  from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 ) where  kupac like '%Austria%' and  TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 )
where kupac like '%Austria%' 
group by kupac,VrstaNarudzbe
union all
-- SONA
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 ) where  kupac LIKE '%SONA%' AND OBRADAA=1 and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 )
where  kupac LIKE '%SONA%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Brasil
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 ) where  kupac LIKE '%SONA%' AND OBRADAA=1 and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 )
where  kupac LIKE '%Brasil%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Romania
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 ) where  kupac LIKE '%Romania%' AND OBRADAA=1 and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 )
where  kupac LIKE '%Romania%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, prsteni
select kupac+' Prsteni',VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 ) where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%prsteni%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 )
where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%prsteni%'
group by kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, valjci
select kupac+' Valjci',VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 ) where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 )
where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%'
group by kupac,VrstaNarudzbe
UNION ALL
-- ostali
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 ) where  gotovo=1 and  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( '2017-08-07' , '2017-08-07' , 0 )
where gotovo=1 and  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%' AND KUPAC NOT LIKE '%Brasil%'
group by kupac,VrstaNarudzbe
END

