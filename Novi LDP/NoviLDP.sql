select sum(kolicinaok)
from EvidNormi('2017-07-26','2017-07-26',0)
where hala=1
and linija='02'

select *
from EvidNormi('2017-07-26','2017-07-26',0)
where hala=1
and linija='02'


USE FeroApp
select v.*,round((v.norma/480.00*trajanjezastoja),0) nedostajekomada
from
(
select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.smjena,e.linija,e.nazivpro,e.norma,e.kolicinaok,e.zavrsnaobrada,e.kupac,e.radnik,z.trajanje trajanjezastoja,z.aktivnost
from evidnormi('2017-08-09','2017-08-09',0) e
left join 
(

SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
FROM ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   left join narudzbesta n on n.brojrn1=plia.brojrn
	   left join proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
	   where pocetak>'2017-08-09 6:00:00' and  kraj<'2017-08-10 6:00'
	   --pl.broj='32'
      --order by hala,naziv,pocetak
) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
) v
where v.aktivnost is not null
order by v.hala,v.smjena,v.linija


USE FeroApp
select v.*,p.NazivPar kupac,round((v.norma/480.00*trajanjezastoja),0) nedostajekomada, datediff(n,vrijemeod,vrijemedo) trajanje_erv, (datediff(n,vrijemeod,vrijemedo)*norma/480 ) planirano
from
(
select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.smjena,e.linija,e.norma,e.kolicinaok,e.id_par,e.radnik,z.trajanje trajanjezastoja,z.aktivnost
from evidencijanormiview e
left join 
(
SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
FROM ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   left join narudzbesta n on n.brojrn1=plia.brojrn
	   left join proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
	   where pocetak>'2017-08-09 6:00:00' and  kraj<'2017-08-10 6:00'
	   --pl.broj='32'
      --order by hala,naziv,pocetak
) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
) v
left join partneri p on p.ID_Par=v.id_par
--where v.aktivnost is not null
where v.datum='2017-08-09'
order by v.hala,v.smjena,v.linija


LEFT JOIN ProizvodneLinije PL ON e.linija = PL.broj
Left join ProizvodneLinijeAktivnosti a on pl.id_pli=a.ID_PLI



where e.hala=1 and e.linija='26'




SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
FROM ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   left join narudzbesta n on n.brojrn1=plia.brojrn
	   left join proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
	   where pocetak>'2017-08-09 6:00:00' and  kraj<'2017-08-10 6:00'
	   order by hala,naziv,pocetak




select norma
from proizvodnenorme
where hala=1 and linija='02' and id_pro in 
(
SELECT ID_PRO
FROM NarudzbeSta
where brojrn1='IK588/16'
)

USE FeroApp
select e.*
from evidnormi('2017-08-02','2017-08-02',0) e
where hala=1 and linija='11'


select *
from evidencijanormiview
where datum='2017-08-02' and hala=1 and linija='11' and brojrn='2717/2017'
and idradnika=129


select *
from evidencijanormiview
where datum='2017-08-02' and id_radnika=129


SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* FROM ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   where hala=1 and broj='11' and brojrn='2717/2017' AND POCETAK >= CONVERT(DateTime, '2017-08-02 06:00:00.000') and pocetak <= CONVERT(DateTime, '2017-08-02 14:00:00.000')
	   order by hala,naziv



select *
from ProizvodneLinijeAktivnosti
	   
select *
from ProizvodneLinije


USE FeroApp
select e.*
from evidnormi('2017-08-01','2017-08-01',0) e
where norma=1


where e.hala=1 and linija='01' and smjena=1


USE FeroApp
select kupac,sum(e.kolicinaok)
from evidnormi('2017-08-01','2017-08-01',0) e
where hala in ( 1,3)
group by kupac


select distinct Kupac
from evidnormi('2017-08-01','2017-08-01',0) e


where e.hala=3



select e.datum,e.hala,e.smjena,e.linija,e.nazivpro,e.norma,e.kolicinaok,e.zavrsnaobrada,e.kupac,e.radnik
from evidnormi('2017-08-09','2017-08-09',0) e
order by hala,smjena,linija

select *
from evidnormi('2017-08-09','2017-08-09',0) e
order by hala,smjena,linija


use rfind
select r.prezime,r.ime,pv.*
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where r.id in ( 307,1016,1111,753,1076)
and pv.datum='2017-06-15'


select *
from evidencijanormiview
where datum='2017-08-09'
order by hala,smjena,linija



select *
from narudzbesta


select v.kupac,v.vrstanarudzbe,count(*) brojstelanja
from (
select e.vrstanarudzbe ,e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.smjena,e.linija,e.nazivpro,e.norma,e.kolicinaok,e.zavrsnaobrada,e.kupac,e.radnik,z.trajanje trajanjezastoja,z.aktivnost
from evidnormi('2017-08-20','2017-08-20',0) e
left join 
(

SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
FROM ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   left join narudzbesta n on n.brojrn1=plia.brojrn
	   left join proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
	   where pocetak>='2017-08-20 6:00:00' and ( kraj<='2017-08-21 6:00' or kraj is null)
	   --pl.broj='32'
      --order by hala,naziv,pocetak
) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
where z.aktivnost like '%Štelanje%'
)v
group by kupac,vrstanarudzbe
order by kupac

