select *
from feroapp.dbo.evidnormi('2018-02-05','2018-02-05',0)
where smjena=2



declare @dat1 date
declare @dat2 date
declare @smjena int
set @dat1='2018-02-05'
set @dat2='2018-02-05'
set @smjena=2


select 'A' hala,kupac,sum(trajanje) ukupnotr
from (
select kupac,case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
where smjena=@smjena and linija not in ('GT600-1','GT600-2','VC510','HURCO')
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
where smjena=@smjena and e1.linija not in ('GT600-1','GT600-2','VC510','HURCO')
) x1
group by kupac
order by kupac







select 'A' hala,'_Ukupno' kupac,sum(trajanje) ukupnotr
from (
select case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
where smjena=@smjena and linija not in ('GT600-1','GT600-2','VC510','HURCO')
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
where smjena=@smjena and e1.linija not in ('GT600-1','GT600-2','VC510','HURCO')
) x1

union all

select 'A' hala,kupac,sum(trajanje) ukupnotr
from (
select kupac,case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
where smjena=@smjena and linija not in ('GT600-1','GT600-2','VC510','HURCO')
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
where smjena=@smjena and e1.linija not in ('GT600-1','GT600-2','VC510','HURCO')
) x1
group by kupac
order by kupac