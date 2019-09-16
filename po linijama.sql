declare @dat1 date
declare @dat2 date

set @dat1 = '2017-11-19'
set @dat2 = '2017-11-19'


--select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(n.CijenaObrada1,0)*isnull(e.Obradaa,0)+isnull(n.CijenaObrada2,0)*isnull(e.Obradab,0)+isnull(n.CijenaObrada3,0)*isnull(e.Obradac,0)*0) cijena,  e.id_par,e.radnik,e.napomena1 napomena
--from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
--left join feroapp.dbo.narudzbesta n on n.brojrn1=e.BrojRN
--where e.kolicinaok>0 and hala=1 and smjena=1

--select v.*,case when vrijemedo>=vrijemeod then datediff(n,vrijemeod,vrijemedo) when vrijemedo<vrijemeod then datediff(n,vrijemeod,vrijemedo)+1440 end  erv,p.NazivPar kupac,pr.nazivpro
--from
--(

--select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(n.CijenaObrada1,0)*isnull(e.Obradaa,0)+isnull(n.CijenaObrada2,0)*isnull(e.Obradab,0)+isnull(n.CijenaObrada3,0)*isnull(e.Obradac,0)*0) cijena,  e.id_par,e.radnik,e.napomena1 napomena
--from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
--left join feroapp.dbo.narudzbesta n on n.brojrn1=e.BrojRN
--where e.kolicinaok>0

--) v
--left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
--left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

--where v.datum=@dat1 and hala=1 and smjena=1


select r.datum,r.hala,sum(r.kolicinaok) kolicinaok,r.linija,r.kupac,sum(r.norma) norma,r.nazivpro,r.cijena,sum(kolicinaok*r.cijena) kolicina,sum(r.erv) erv
from (
select v.*,case when vrijemedo>=vrijemeod then datediff(n,vrijemeod,vrijemedo) when vrijemedo<vrijemeod then datediff(n,vrijemeod,vrijemedo)+1440 end  erv,p.NazivPar kupac,pr.nazivpro
from
(

select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(n.CijenaObrada1,0)*isnull(e.Obradaa,0)+isnull(n.CijenaObrada2,0)*isnull(e.Obradab,0)+isnull(n.CijenaObrada3,0)*isnull(e.Obradac,0)*0) cijena,  e.id_par,e.radnik,e.napomena1 napomena
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn1=e.BrojRN
where e.kolicinaok>0

) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

where v.datum=@dat1 

) r
where hala=1 and smjena=1
group by r.datum,r.hala,r.linija,r.nazivpro,r.cijena,r.kupac
order by r.datum,r.hala,r.linija



