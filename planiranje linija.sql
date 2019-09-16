declare @dat1 varchar(20)='2017-08-22 '
declare @dat2 varchar(20)='2017-08-22'
declare @id int=1

select v.*,p.NazivPar kupac,pr.nazivpro,round((v.norma/480.00*trajanjezastoja),0) nedostajekomada, case when vrijemedo>vrijemeod then datediff(n,vrijemeod,vrijemedo) else datediff(n,vrijemeod,vrijemedo)+1440 end trajanje_erv, case when vrijemedo > vrijemeod then (datediff(n,vrijemeod,vrijemedo)*norma/480 ) else  ((1440+datediff(n,vrijemeod,vrijemedo))*norma/480 ) end planirano
from
(
select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(n.CijenaObrada1,0)*isnull(n.Obrada1,0)+isnull(n.CijenaObrada2,0)*isnull(n.Obrada2,0)+isnull(n.CijenaObrada3,0)*isnull(n.Obrada3,0)) cijena,  e.id_par,e.radnik,z.trajanje trajanjezastoja,z.aktivnost,e.napomena1 napomena
from feroapp.dbo.evidencijanormiview e
left join feroapp.dbo.narudzbesta n on n.brojrn1=e.BrojRN
left join
(
SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   left join feroapp.dbo.narudzbesta n on n.brojrn1=plia.brojrn
	   left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
	   where pocetak >= @dat1 and  kraj <= @dat2

) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro
where v.datum=@dat1 and smjena=@id
order by v.hala,v.smjena,v.linija