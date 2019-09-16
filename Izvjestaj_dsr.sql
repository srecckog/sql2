-- PLANIRANO, PO SMJENAMA
declare @dat1 date
declare @dat2 date
declare @smjena int

set @dat1='2017-12-04 22:00:00' 
set @dat2='2017-12-05 06:00:00' 
set @smjena =3


select kupac,vrstanarudzbe,sum(norma) norma,'T' vo
from (

select kupac,vrstanarudzbe,sum(norma) norma,'T' vo
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  not in ('GT600-1','GT600-2','VC510','HURCO') and smjena=@smjena 
GROUP BY KUPAC,vrstanarudzbe

union all

select kupac,vrstanarudzbe,sum(norma*-1) norma,'T' vo
from (
select count(*) broj,hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
from (
select hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  not in ('GT600-1','GT600-2','VC510','HURCO') and smjena=@smjena
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
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  in ('GT600-1','GT600-2','VC510','HURCO') and smjena=@smjena
GROUP BY KUPAC,vrstanarudzbe
union all
select kupac,vrstanarudzbe,sum(norma*-1) norma,'DO' vo
from (
select count(*) broj,hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
from (
select hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  in ('GT600-1','GT600-2','VC510','HURCO') and smjena=@smjena
group by hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
) x1
group by hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
having count(*)=2 
) x2
GROUP BY KUPAC,vrstanarudzbe
) x3
group by kupac,vrstanarudzbe,vo
order by kupac


-- REALIZACIJA
declare @dat1 date
declare @dat2 date
declare @smjena int

set @dat1='2017-12-04 22:00:00' 
set @dat2='2017-12-05 06:00:00' 
set @smjena =3

SELECT * 
FROM feroapp.dbo.EvidencijaProizvedenoFakturirano_Zbirno_SG(@dat1, @dat2, @smjena)