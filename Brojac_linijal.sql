declare @dat1 date,@dat2 date
@dat1='2017-08-08'
@dat2= '2017-08-08'
begin
-- BDF

select kupac,VrstaNarudzbe,count(*) broj_linija from (

declare @dat2 date = '2017-08-08'
declare @dat1 date = '2017-08-08'

select kupac,sum(trajanje) ukupnotr
from (
select kupac,case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
) x1
group by kupac

select *
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
where hala=1
order by linija


declare @dat2 date = '2017-08-03'
declare @dat1 date = '2017-08-03'

select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  gotovo=1 and obrada3=0 and KolicinaOK >= 0
and hala=1 and linija='09'




order by linija,hala

) x1
group by kupac,VrstaNarudzbe




select kupac,VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  gotovo=1 and kupac like '%Austria%' and obrada3=0 and KolicinaOK > 0
) x1
group by kupac,VrstaNarudzbe

union all
-- SONA
select kupac,VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SONA%' AND OBRADAA=1) x1
group by kupac,VrstaNarudzbe
UNION ALL
-- Brasil
select kupac,VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Brasil%' AND OBRADAA=1) x1
group by kupac,VrstaNarudzbe

UNION ALL
-- BMW
select kupac,VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%WEINFURT%' AND OBRADAA=1) x1
group by kupac,VrstaNarudzbe

UNION ALL

-- Romania

select kupac,VrstaNarudzbe,count(*) broj_linija from (

select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( '2017-08-02','2017-08-02' , 0 )
where kupac LIKE '%Romania%' --AND OBRADAA=1 

) x1
group by kupac,VrstaNarudzbe


union all
-- Schaeffler Technologies, prsteni
select kupac+'Prsteni',VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%prsteni%' ) x1
group by kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, valjci
select kupac+'Valjci',VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%') x1
group by kupac,VrstaNarudzbe
UNION ALL
-- ostali
select kupac,VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where gotovo=1 and  kupac not like '%weinfurt%' AND kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%' AND KUPAC NOT LIKE '%Brasil%') x1
group by kupac,VrstaNarudzbe
end
-----------------------
declare @dat2 date = '2017-08-08'
declare @dat1 date = '2017-08-08'

begin
select kupac,vrstanarudzbe,count(*) broj_linija
from(

select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1, @dat2 , 0 )
where  gotovo=1 and obrada3=0 and KolicinaOK >= 0



) x1
group by kupac,vrstanarudzbe
order by kupac
end



declare @dat2 date = '2017-08-08'
declare @dat1 date = '2017-08-08'
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1, @dat2 , 0 )
where  gotovo=1 and obrada3=0 and KolicinaOK >= 0
order by kupac

