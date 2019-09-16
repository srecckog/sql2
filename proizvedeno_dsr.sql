
declare @dat1 date
declare @dat2 date
set @dat1='2017-12-13'
set @dat2='2017-12-13';

--select *
--from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
--where linija IN ('09-S') and hala=3

--select sum(x1.kolicinaok)
--from (

select r.datum,r.hala,r.id_pro,r.brojrn,sum(r.kolicinaok) kolicinaok,r.linija,r.kupac,sum(r.norma) norma,r.nazivpro,r.cijena,sum(kolicinaok*r.cijena) kolicina,sum(isnull(r.erv,0)) erv,sum(norma1) normukup
from (
select v.*,case when vrijemedo>=vrijemeod then datediff(n,vrijemeod,vrijemedo) when vrijemedo<vrijemeod then datediff(n,vrijemeod,vrijemedo)+1440 end  erv,p.NazivPar kupac,pr.nazivpro,480 norma1
from
(

select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(n.CijenaObrada1,0)*isnull(E.ObradaA,0)+isnull(n.CijenaObrada2,0)*isnull(E.ObradaB,0)+isnull(n.CijenaObrada3,0)*isnull(E.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
--where e.kolicinaok>0

) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

where v.datum=@dat1 --AND KUPAC LIKE '%G%'
--and linija not in ('VC510','HURCO','GT600-1','GT600-2')
--AND KUPAC LIKE '%Austria%'
and hala=3
) r
group by r.datum,r.hala,r.linija,r.brojrn,r.nazivpro,r.cijena,r.kupac,r.id_pro
--) x1
order by r.datum,r.hala,r.linija,r.id_pro,r.brojrn


USE FEROAPP
SELECT *
FROM EVIDNORMI('2017-12-13','2017-12-13',0)
WHERE LINIJA='09-S'


