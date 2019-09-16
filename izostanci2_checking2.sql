--update plansatirada2 set dan01 ='0y'
--where '2019-05-01' in ( select datum from praznici)
--and dan01 is null and mjesec=5 and godina=2019

update rfind.dbo.plansatirada2 set dan08 =null where mjesec=7 and godina=2019

select * into rfind.dbo.plansatirada2
from fxsap.dbo.plansatirada
where mjesec=5 and godina=2019

select ime,dan15

select *
from rfind.dbo.plansatirada2
where radnikid!=1648
and mjesec=5 and godina=2019
and sifrarm='Režija' 
and dan18='0e'


select *
from feroapp.dbo.radnici
where neradi=0 and sifrarm='Režija'
order by ime

begin transaction
--update FeroApp.dbo.radnici set sifrarm='Režija' where id_radnika=133
end transaction


select a.prezime,a.ime,a.neradi,p.firma,a.neradi,v.dosao,v.otisao 
from plansatirada2 p 
left join feroapp.dbo.radnici r on r.id_fink = p.radnikid and r.id_firme = p.Firma 
left join rfind.dbo.radnici_ a on a.id_radnika = r.id_radnika 
left join pregledvremena v on v.IDRadnika=a.id and v.datum='2019-05-03'
where a.neradi=0 and mjesec =5 and godina = 2019 and a.datumzaposlenja<='2019-05-06' 
and  r.sifrarm='Režija' and year(v.dosao)=1900
order by p.ime 



select r.neradi,p.firma,p.*,dan17,a.neradi 
from rfind.dbo.plansatirada2 p 
left join feroapp.dbo.radnici r on r.id_fink = p.radnikid and r.id_firme = p.Firma 
left join rfind.dbo.radnici_ a on a.id_radnika = r.id_radnika 
left join rfind.dbo.pregledvremena v on v.IDRadnika=a.id and v.datum= '2019-05-03' 
where a.neradi=0 and mjesec = 5 and godina = 2019 and a.datumzaposlenja<='2019-05-03 12:12' and r.sifrarm='Režija' and year(v.dosao)!=1900 order by ime 


select r.neradi,p.firma,p.*,dan17,a.neradi 
from rfind.dbo.plansatirada2 p 
left join feroapp.dbo.radnici r on r.id_fink = p.radnikid and r.id_firme = p.Firma 
left join rfind.dbo.radnici_ a on a.id_radnika = r.id_radnika 
left join rfind.dbo.pregledvremena v on v.IDRadnika=a.id and v.datum= '2019-05-3' 
where a.neradi=0 and mjesec = 5 and godina = 2019 and a.datumzaposlenja<='2019-05-3' and r.sifrarm='Režija' and year(v.dosao)!=1900 order by ime


select ime,mt,dan
from plansatirada2
where mjesec=5 and godina=2019
and sifrarm!='Režija' and mt=716
order by ime


select r.neradi,p.firma,p.radnikid,p.ime,Dan09,v.dosao,v.otisao,v.ukupno_minuta,v.smjena,a.fixnaisplata,a.mt 
from rfind.dbo.plansatirada2 p 
left join feroapp.dbo.radnici r on r.id_fink = p.radnikid and r.id_firme = p.Firma 
left join rfind.dbo.radnici_ a on a.id_radnika = r.id_radnika 
left join rfind.dbo.pregledvremena v on v.idradnika = a.id and v.Datum = '2019-05-9' 
where mjesec = 5 and godina = 2019 and v.ukupno_minuta > 465 and Dan09 is null  
order by ime


select *
from feroapp.dbo.radnici
where ime like '%ZORAN%'


select ime,radnikid,firma,dan14
--from fxsap.dbo.plansatirada
from rfind.dbo.plansatirada2
where mjesec=5 and godina=2019
and sifrarm='Režija'

select ime,radnikid,firma,dan14
--from fxsap.dbo.plansatirada
from fxsap.dbo.plansatirada
where mjesec=5 and godina=2019
and mt=702


and sifrarm='Režija'


-- provjera excel izostanci

select p.firma,p.radnikid,p.ime,p.sifrarm,p.mt,dan14 ,v.radnomjesto,v.hala,v.smjena,v.napomena
from rfind.dbo.plansatirada2 p 
left join feroapp.dbo.radnici r1 on r1.ID_Fink=p.RadnikID and r1.ID_Firme=p.Firma 
left join rfind.dbo.radnici_ r2 on r2.id_radnika=r1.id_radnika 
left join rfind.dbo.pregledvremena v on idradnika=r2.id and v.datum='2019-05-14'
where mjesec=5 and godina=2019 and dan14 not in ( '0j','7g','5g','8b') and ( dan14 is null or dan14 ='0e' or dan14 like '0e:%' or dan14 like '%:0e'  ) and ( dan14 like '1j:1p' or dan14 like '1p:1n' or dan14 like '1n:1j' ) and p.firma=r1.id_firme and p.mt not in ( 7021,7101) and r2.neradi=0 

union all 

select firma,radnikid,p.ime,p.sifrarm,p.mt,dan14 ,v.radnomjesto,v.hala,v.smjena,v.napomena
from rfind.dbo.plansatirada2 p 
left join feroapp.dbo.radnici r1 on r1.ID_Fink=p.RadnikID and r1.ID_Firme=p.Firma 
left join rfind.dbo.radnici_ r2 on r2.id_radnika=r1.id_radnika 
left join rfind.dbo.pregledvremena v on idradnika=r2.id and v.datum='2019-05-14'
where mjesec=5 and godina=2019 and ( dan14 not like '1j' and dan14 not like '1p' and dan14 not like '1n' and dan14 not in ( '0j','7g','5g','8b','0e')) 
order by dan14,radnomjesto,mt,ime 

rfind.dbo.izostanci3 '2019-05-14',3


select *
from radnici_
where id=1648

--update radnici_ set fixnaisplata=1 where id=1648

select *
from feroapp.dbo.radnici
where id_fink=1648


select ime,dan16
from fxsap.dbo.plansatirada
where mjesec=5 and godina=2019

select *
from rfind.dbo.pregledvremena
where idradnika=673
and datum='2019-05-18'
