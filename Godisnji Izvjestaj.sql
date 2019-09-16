declare @dat1 date
declare @dat2 date
set @dat1=cast(year(getdate()) as varchar)+'-01-01'
set @dat2='2088-03-21'


select mm Mjesec,sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'TOK' vo
from (
select e.datum,month(e.datum) mm,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3')
) x1
group by VrstaNarudzbe,kupac,mm

union all

select mm,sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'DO' vo
from (
select e.datum,month(e.datum) mm,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija in ('HURCO','VC510','GT600-1','GT600-2','GT600-3')
) x1
group by VrstaNarudzbe,kupac,mm
order by mm,kupac
