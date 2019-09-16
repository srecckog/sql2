declare @dat1 date='2019-11-12'
declare @dat2 date='2019-11-13'
declare @hala int = 1

select kupac,vrstapro,sum(kolicina) kolicina,sum(vrijednost) vrijednost
from (
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,x1.VrstaNarudzbe vrstapro,x1.kupac,'TOK' vo,x1.id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat1,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5')
and smjena!=1 and hala=@hala
) x1
group by VrstaNarudzbe,kupac,id_par
union all
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'DO' vo,id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where ( linija in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5') or e.obrada3 =1)
--and e.obrada3=0 and e.gotovo=1
and smjena!=1 and hala=@hala
) x1
group by x1.VrstaNarudzbe,x1.kupac,x1.id_par

union all

select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,x1.VrstaNarudzbe vrstapro,x1.kupac,'TOK' vo,x1.id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat2,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5')
and smjena=1 and hala=@hala
) x1
group by VrstaNarudzbe,kupac,id_par
union all
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'DO' vo,id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat2,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where ( linija in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5') or e.obrada3 =1)
--and e.obrada3=0 and e.gotovo=1
and smjena=1 and hala=@hala
) x1
group by x1.VrstaNarudzbe,x1.kupac,x1.id_par
) y1
where vo='TOK'
group by kupac,id_par,vrstapro
order by y1.id_par,y1.vrstapro

------------------------
--  vikend
------------------------
declare @dat1 date='2019-01-25'  -- petak 2 i 3 smjena
declare @dat2 date='2019-01-26'  -- subota
declare @dat3 date='2019-01-27'  -- nedjelja 
declare @dat4 date='2019-01-28'  -- ponedjeljak 1.smjena
declare @hala int = 1

select hala,kupac,vrstapro,sum(kolicina) kolicina,cast (sum(vrijednost) as float ) vrijednost
from (
select hala,sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,x1.VrstaNarudzbe vrstapro,x1.kupac,'TOK' vo,x1.id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat1,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5')
and smjena!=1 
) x1
group by VrstaNarudzbe,kupac,id_par,hala

union all

select hala,sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,x1.VrstaNarudzbe vrstapro,x1.kupac,'TOK' vo,x1.id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat2,@dat3,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5')
) x1
group by VrstaNarudzbe,kupac,id_par,hala

union all

select hala,sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,x1.VrstaNarudzbe vrstapro,x1.kupac,'TOK' vo,x1.id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat4,@dat4,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5')
and smjena=1 
) x1
group by VrstaNarudzbe,kupac,id_par,hala

) y1
where vo='TOK'
group by kupac,id_par,vrstapro,hala
order by y1.id_par,y1.vrstapro

