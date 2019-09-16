 
             SELECT (CASE WHEN LEN(PomocniRadnik) > 6 THEN RIGHT(PomocniRadnik,LEN(PomocniRadnik)-6) END) AS Radnik,
             (SELECT TOP 1 MT FROM FxSAP.dbo.PlanSatiRada WHERE RadnikID = (SELECT ID_Fink FROM Radnici WHERE ID_Radnika = EvidNormiRada.ID_Radnika) ORDER BY PsrID DESC) AS MT, EvidNormiRada.Hala,'1' tip
             FROM EvidNormiRada('2018-09-01', '2018-09-30') 
			 INNER JOIN Radnici ON EvidNormiRada.ID_Radnika2=Radnici.ID_Radnika
             WHERE PomocniRadnik <> '' AND Vrsta NOT IN ('Šteler') AND Radnici.Kontrola = 0
             AND PomocniRadnik <> 'Pomoæ '
			 --order by radnik

             Union

             SELECT Radnik,
             (SELECT TOP 1 MT FROM FxSAP.dbo.PlanSatiRada WHERE RadnikID = (SELECT ID_Fink FROM Radnici WHERE ID_Radnika = EvidNormiRada.ID_Radnika) ORDER BY PsrID DESC) AS MT, EvidNormiRada.Hala,'2' tip
             FROM EvidNormiRada('2018-09-01', '2018-09-30') 
			 LEFT JOIN Radnici  ON EvidNormiRada.ID_Radnika=Radnici.ID_Radnika
             WHERE Radnik <> '' AND Vrsta NOT IN ('Šteler') AND Radnici.Kontrola = 0
			-- order by radnik

             Union

             SELECT Radnik, (SELECT TOP 1 MT FROM FxSAP.dbo.PlanSatiRada WHERE RadnikID = (SELECT ID_Fink FROM Radnici WHERE ID_Radnika = EvidNormiRada.ID_Radnika) ORDER BY PsrID DESC) AS MT, EvidNormiRada.Hala, '3' tip
             FROM EvidNormiRada('2018-09-01', '2018-09-30') WHERE Vrsta = 'Šteler' ORDER BY Radnik

-------------------
			
			 select r.prezime,r.ime,x2.*
			 from (
			 select x1.*,p.dosao,p.otisao,p.Ukupno_minuta,p.RadnoMjesto, case when dosao is null then 'Nije zaplaniran' when year(dosao)=1900 then 'Nije se prijavio' when year(dosao)=1900 then 'Nije se prijavio' end napomena, case when x1.smjena=3 and x1.satiradaradnika>=8 then '1n' when x1.smjena=2 and x1.satiradaradnika>=8 then '1p' when x1.smjena=1 and x1.satiradaradnika>=8 then '1j' when x1.smjena=3 and x1.satiradaradnika<8 and x1.satiradaradnika>0 then ('-'+cast((7.0-x1.satiradaradnika) as varchar(12)) + 'n') when x1.smjena=2 and x1.satiradaradnika<8 and x1.satiradaradnika>0  then ('-'+cast((7.0-x1.satiradaradnika) as varchar(12)) + 'p') when x1.satiradaradnika=0 then '0e' when x1.smjena=1 and x1.satiradaradnika<8 and x1.satiradaradnika>0 then ('-'+cast((7.0-x1.satiradaradnika) as varchar(12)) + 'j' ) end oznaka from (
			 select x11.* from (
			 select x11.*,id from (
			 select e.id_radnika,e.firma,e.datum,e.hala,e.smjena,sum(e.satiradaradnika) satiradaradnika
			 FROM EvidNormiRada('2018-09-01', '2018-09-30') e 
			 group by e.id_radnika,e.firma,e.datum,e.hala,e.smjena
			 ) x11
			 inner join rfind.dbo.radnici_ r on r.id_radnika=x11.id_radnika 
			 ) x11
			 union all
			 select x12.* from (
			 select x12.*,id from (
			 select e.id_radnika2 id_radnika,e.firma,e.datum,e.hala,e.smjena,sum(e.satiradaradnika) satiradaradnika
			 FROM EvidNormiRada('2018-09-01', '2018-09-30') e 
			 where pomocniradnik is not null and  pomocniradnik!=''
			 group by e.id_radnika2,e.firma,e.datum,e.hala,e.smjena
			 ) x12
			 inner join rfind.dbo.radnici_ r on r.id_radnika=x12.id_radnika
			 ) x12		 
			 ) x1
			 left join rfind.dbo.pregledvremena p on p.IDRadnika=x1.id and p.datum=x1.datum and x1.smjena=p.smjena			
			 ) x2
			 inner join rfind.dbo.radnici_ r on r.id_radnika=x2.id_radnika
			 order by r.prezime,x2.id_radnika,x2.smjena
			 
---------
			 select *
			 from rfind.dbo.radnici_
			 where prezime like 'KOME%'

			 select *
			 from feroapp.dbo.radnici
			 where ime like 'ARS%'

			 select *
			 from rfind.dbo.pregledvremena
			 where idradnika=1357
			 order by datum desc

			 select distinct id_radnika
			 FROM EvidNormiRada('2018-10-16', '2018-10-16') e 
			 where id_radnika2=1506




			  WHERE Vrsta != 'Šteler'
			 order by radnik


			 
			 select *
			 from rfind.dbo.radnici_
			 where id_radnika=2161

			 order by id desc


			 where prezime like 'KOME%'


		-- update rfind.dbo.radnici_ set id_radnika=null where id=900051


			 select *
			 from fxsap.dbo.PlanSatiRada
			 where mjesec=10 and godina=2018
			 and dan15 is not null


			select x1.* ,p.dosao,p.otisao,p.ukupno_minuta,p.radnomjesto,p.smjena,p.hala from (
			select radnikid,ime,sifrarm,vrstarm,mt,dan15
			from rfind.dbo.plansatirada2
			where mjesec=10 and godina=2018
			and mt=700 and dan15 is null ) x1
			left join rfind.dbo.pregledvremena p on p.IDRadnika=x1.radnikid and p.datum='2018-10-15' 
			order by ime
			--where ukupno_minuta>0 


			 select x1.id_radnika,x1.firma,x1.datum,x1.hala,x1.smjena,satiradaradnika,id from (
			 select e.id_radnika,e.firma,e.datum,e.hala,e.smjena,sum(e.satiradaradnika) satiradaradnika
			 FROM EvidNormiRada('2018-10-16', '2018-10-16') e 
			 group by e.id_radnika,e.firma,e.datum,e.hala,e.smjena
			 ) x1
			 inner join rfind.dbo.radnici_ r on r.id_radnika=x1.id_radnika 
			 order by id_radnika

			-- where pomocniradnik is null or  pomocniradnik=''
			 group by x1.id_radnika,x1.firma,x1.datum,x1.hala,x1.smjena,x1.id


use fxsap
select * into rfind.dbo.plansatirada2
from plansatirada


select * --firma,radnikid,ime,mt,dan15,dan16
 from  rfind.dbo.plansatirada2 
where mjesec=10 and godina=2018 --and radnikid= 1269 and firma=3 
--and radnikid=2137
and mt=700 and dan16 is null
order by ime


select *
from rfind.dbo.plansatirada2 where ime like 'ars%'


select *
FROM feroapp.dbo.EvidNormiRada('2018-10-16', '2018-10-16') 
where vrsta='Šteler'
order by id_radnika
