declare @dat1 date
declare @dat2 date
set @dat1='2019-8-01'
set @dat2='2019-8-31';


--select sum(kolicinaok)
--from (
select datum,brojrn,NazivPro,id_par,kupac,kolicinaok, CAST(cijena AS FLOAT) cijena,VrstaNarudzbe,VO
from (
select e.datum,e.hala,e.brojrn,e.NazivPro,e.id_par,e.kupac,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0) +isnull(e.CijenaObradaf,0)*isnull(e.Obradaf,0) +isnull(e.CijenaObradag,0)*isnull(e.Obradag,0)+isnull(e.CijenaObradah,0)*isnull(e.Obradah,0)+ isnull(e.CijenaObradai,0)*isnull(e.Obradai,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,e.VrstaNarudzbe,'Tokarenje' VO
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
and e.obrada3=0 
--group by VrstaNarudzbe,kupac,id_par
union all
select e.datum,e.hala,e.brojrn,e.NazivPro,e.id_par,e.kupac,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0) +isnull(e.CijenaObradaf,0)*isnull(e.Obradaf,0) +isnull(e.CijenaObradag,0)*isnull(e.Obradag,0)+isnull(e.CijenaObradah,0)*isnull(e.Obradah,0)+ isnull(e.CijenaObradai,0)*isnull(e.Obradai,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,e.VrstaNarudzbe,'DodatnaObrada' VO
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where ( linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4') or e.obrada3 =1)
--and e.obrada3=0 and e.gotovo=1
--group by VrstaNarudzbe,kupac,id_par
--)x1
--where vo like '%Tokarenje%' and id_par=274
) x1
--where  cijena=0 and brojrn like '3336/2018'
order by vo,datum,id_par



select *
from feroapp.dbo.evidnormi('2018-10-01','2018-10-01',0) 
where brojrn like 'SONA/619/2018'

declare @dat1 date
declare @dat2 date
set @dat1='2019-7-01'
set @dat2='2019-7-30';


--select sum(kolicinaok)
--from (

select Hala,id_par,Kupac,sum(kolicinaok) Kolièina,sum(kolicinaok*cijena) Vrijednost_eur, Vrstanarudzbe
from (


-- sumarno po kupcima

select datum,hala,brojrn,NazivPro,id_par,kupac,kolicinaok, CAST(cijena AS FLOAT) cijena,VrstaNarudzbe,VO
from (
select e.datum,e.hala,e.brojrn,e.NazivPro,e.id_par,e.kupac,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0) +isnull(e.CijenaObradaf,0)*isnull(e.Obradaf,0) +isnull(e.CijenaObradag,0)*isnull(e.Obradag,0)+isnull(e.CijenaObradah,0)*isnull(e.Obradah,0)+ isnull(e.CijenaObradai,0)*isnull(e.Obradai,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,e.VrstaNarudzbe,'Tokarenje' VO
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','GT600-4','GT600-5')
and e.obrada3=0 
--group by VrstaNarudzbe,kupac,id_par
union all
select e.datum,e.hala,e.brojrn,e.NazivPro,e.id_par,e.kupac,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0) +isnull(e.CijenaObradaf,0)*isnull(e.Obradaf,0) +isnull(e.CijenaObradag,0)*isnull(e.Obradag,0)+isnull(e.CijenaObradah,0)*isnull(e.Obradah,0)+ isnull(e.CijenaObradai,0)*isnull(e.Obradai,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,e.VrstaNarudzbe,'DodatnaObrada' VO
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where ( linija in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','GT600-4','GT600-5') or e.obrada3 =1)
--and e.obrada3=0 and e.gotovo=1
--group by VrstaNarudzbe,kupac,id_par
--)x1
--where vo like '%Tokarenje%' and id_par=274
) x1
--where  cijena=0 and brojrn like '3336/2018'
) xc
group by id_par,kupac,vrstanarudzbe,hala
order by id_par,vrstanarudzbe,hala


















select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'TOK' vo,id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3')
and e.obrada3=0 
) x1
group by VrstaNarudzbe,kupac,id_par
union all
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'DO' vo,id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where ( linija in ('HURCO','VC510','GT600-1','GT600-2','GT600-3') or e.obrada3 =1)
--and e.obrada3=0 and e.gotovo=1
) x1
group by VrstaNarudzbe,kupac,id_par


use feroapp
select *
from evidnormi('2018-10-01','2018-10-31',0)
where brojrn like '%IK415%'


select *
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi('2018-10-01','2018-10-31',0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3')
and e.obrada3=0 
) x1
where brojrn like '%IK415%'



declare @dat1 date
declare @dat2 date
set @dat1='2018-12-01'
set @dat2='2018-12-31';


--select sum(kolicinaok)
--from (
select id_par,kupac,sum(kolicinaok) kolicina,cast( sum(cijena*kolicinaok) as float) vrijednost,vrstanarudzbe,vo
from (
select e.datum,e.brojrn,e.NazivPro,e.id_par,e.kupac,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0) + isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,e.VrstaNarudzbe,'Tokarenje' VO
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','GT600-4','GT600-5')
and e.obrada3=0 
--group by VrstaNarudzbe,kupac,id_par
union all
select e.datum,e.brojrn,e.NazivPro,e.id_par,e.kupac,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0) + isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,e.VrstaNarudzbe,'DodatnaObrada' VO
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where ( linija in ('HURCO','VC510','GT600-1','GT600-2','GT600-3','GT600-4','GT600-5') or e.obrada3 =1)
--and e.obrada3=0 and e.gotovo=1
--group by VrstaNarudzbe,kupac,id_par
--)x1
--where vo like '%Tokarenje%' and id_par=274
) x1
--where  cijena=0 and brojrn like '3336/2018'
group by id_par,kupac,vrstanarudzbe,vo
order by id_par
