use feroapp
declare @hala varchar(50)
declare @dat1 date='2019-05-15'
declare @dat2 date='2019-05-15'

select z1.*
from (
select y1.*,r.Ime radnik,i.id,p.Dan15,CASE when SMJENA=1 and sati >0 THEN STR(SATI-7)+'j'  when SMJENA=2 and sati >0  THEN STR(SATI-7)+'p' when SMJENA=3 and sati >0 THEN STR(saTI-7)+'n' when sati=0 then '0e'  end oznaka
from (
select id_radnika,case when sati>8 then 8 else sati end sati,smjena
	 from (
select id_radnika,sum(satiradaradnika) sati,smjena
from (
select x1.*  --,pv.Ukupno_sati
  from (
SELECT 1 tip,EvidNormiRada.ID_Radnika2 id_radnika,(CASE WHEN LEN(PomocniRadnik) > 6 THEN RIGHT(PomocniRadnik,LEN(PomocniRadnik)-6) END) AS Radnik,
         Datum, Smjena,
         SUM(SatiRadaPomocnogRadnika) AS SatiRadaRadnika, Vrsta, Napomena1, Napomena2
         FROM EvidNormiRada(@dat1, @dat2)
         INNER JOIN Radnici ON EvidNormiRada.ID_Radnika2=Radnici.ID_Radnika
         WHERE (EvidNormiRada.Hala = '1' OR EvidNormiRada.Hala = '3') AND PomocniRadnik <> '' AND Vrsta NOT IN ('Šteler')
         AND Radnici.Kontrola = 0 AND PomocniRadnik <> 'Pomoæ '
         GROUP BY EvidNormiRada.ID_Radnika2,EvidNormiRada.ID_Radnika,pomocniradnik,EvidNormiRada.PomocniRadnik, EvidNormiRada.ID_Radnika, EvidNormiRada.Datum, EvidNormiRada.Smjena, EvidNormiRada.Vrsta, EvidNormiRada.Napomena1, EvidNormiRada.Napomena2, EvidNormiRada.SatiRadaPomocnogRadnika 

         UNION ALL 

         SELECT 2 tip,EvidNormiRada.ID_Radnika,Radnik, Datum, Smjena, SUM(SatiRadaRadnika) AS SatiRadaRadnika, Vrsta, Napomena1, Napomena2 FROM EvidNormiRada(@dat1, @dat2) INNER JOIN Radnici ON
         EvidNormiRada.ID_Radnika=Radnici.ID_Radnika WHERE (EvidNormiRada.Hala = '1' OR EvidNormiRada.Hala = '3') AND Radnik <> '' AND Vrsta NOT IN ('Šteler') AND Radnici.Kontrola = 0
         GROUP BY pomocniradnik,EvidNormiRada.ID_Radnika2,EvidNormiRada.Radnik, EvidNormiRada.ID_Radnika, EvidNormiRada.Datum, EvidNormiRada.Smjena, EvidNormiRada.Vrsta, EvidNormiRada.Napomena1, EvidNormiRada.Napomena2, EvidNormiRada.SatiRadaRadnika
         union all

		 SELECT 3 tip,EvidNormiRada.id_radnika,Radnik, Datum, Smjena, SUM(SatiRadaRadnika)  AS SatiRadaRadnika, Vrsta, Napomena1, Napomena2		 
         FROM EvidNormiRada(@dat1, @dat2) WHERE (EvidNormiRada.Hala = '1' OR EvidNormiRada.Hala = '3') AND Vrsta = 'Šteler'
         GROUP BY pomocniradnik,EvidNormiRada.ID_Radnika2,EvidNormiRada.Radnik, EvidNormiRada.ID_Radnika, EvidNormiRada.Datum, EvidNormiRada.Smjena, EvidNormiRada.Vrsta, EvidNormiRada.Napomena1, EvidNormiRada.Napomena2, EvidNormiRada.SatiRadaRadnika) x1
		 ) x2
		 group by id_radnika,smjena,radnik) x3
		 ) y1
		 left join feroapp.dbo.radnici r on r.ID_Radnika=y1.id_radnika
		 left join rfind.dbo.radnici_ i on i.ID_Radnika=r.id_radnika
		 left join fxsap.dbo.plansatirada p on r.ID_Fink=p.RadnikID
		 where p.mjesec=5 and godina=2019		 
		 ) z1
		 where ltrim(rtrim(oznaka))!=ltrim(rtrim(Dan15)) and dan15 not in ('7g')
		 order by radnik



use feroapp
declare @hala varchar(50)
declare @dat1 date='2019-05-14'
declare @dat2 date='2019-05-14'

-- pomoæni radnik
SELECT 1 tip,EvidNormiRada.ID_Radnika2 id_radnika,(CASE WHEN LEN(PomocniRadnik) > 6 THEN RIGHT(PomocniRadnik,LEN(PomocniRadnik)-6) END) AS Radnik,
         Datum, Smjena,
         SUM(SatiRadaPomocnogRadnika) AS SatiRadaRadnika, Vrsta, Napomena1, Napomena2
         FROM EvidNormiRada(@dat1, @dat2)
         INNER JOIN Radnici ON EvidNormiRada.ID_Radnika2=Radnici.ID_Radnika
         WHERE (EvidNormiRada.Hala = '1' OR EvidNormiRada.Hala = '3') AND PomocniRadnik <> '' AND Vrsta NOT IN ('Šteler')
         AND Radnici.Kontrola = 0 AND PomocniRadnik <> 'Pomoæ '
         GROUP BY EvidNormiRada.ID_Radnika2,EvidNormiRada.ID_Radnika,pomocniradnik,EvidNormiRada.PomocniRadnik, EvidNormiRada.ID_Radnika, EvidNormiRada.Datum, EvidNormiRada.Smjena, EvidNormiRada.Vrsta, EvidNormiRada.Napomena1, EvidNormiRada.Napomena2, EvidNormiRada.SatiRadaPomocnogRadnika 


-- šteleri
		 SELECT 3 tip,EvidNormiRada.id_radnika,Radnik, Datum, Smjena, SUM(SatiRadaRadnika)  AS SatiRadaRadnika, Vrsta, Napomena1, Napomena2		 
         FROM EvidNormiRada(@dat1, @dat2) WHERE (EvidNormiRada.Hala = '1' OR EvidNormiRada.Hala = '3') AND Vrsta = 'Šteler'
         GROUP BY pomocniradnik,EvidNormiRada.ID_Radnika2,EvidNormiRada.Radnik, EvidNormiRada.ID_Radnika, EvidNormiRada.Datum, EvidNormiRada.Smjena, EvidNormiRada.Vrsta, EvidNormiRada.Napomena1, EvidNormiRada.Napomena2, EvidNormiRada.SatiRadaRadnika

-- ostali
		          SELECT 2 tip,EvidNormiRada.ID_Radnika,Radnik, Datum, Smjena, SUM(SatiRadaRadnika) AS SatiRadaRadnika, Vrsta, Napomena1, Napomena2 FROM EvidNormiRada(@dat1, @dat2) INNER JOIN Radnici ON
         EvidNormiRada.ID_Radnika=Radnici.ID_Radnika WHERE (EvidNormiRada.Hala = '1' OR EvidNormiRada.Hala = '3') AND Radnik <> '' AND Vrsta NOT IN ('Šteler') AND Radnici.Kontrola = 0
         GROUP BY pomocniradnik,EvidNormiRada.ID_Radnika2,EvidNormiRada.Radnik, EvidNormiRada.ID_Radnika, EvidNormiRada.Datum, EvidNormiRada.Smjena, EvidNormiRada.Vrsta, EvidNormiRada.Napomena1, EvidNormiRada.Napomena2, EvidNormiRada.SatiRadaRadnika


		 -- šteleri
		 select ime,dan09
		 from fxsap.dbo.plansatirada
		 where mjesec=5 and godina=2019 and mt=716 


		 -- novi djelatnici
		 --select *
		 --from fxsap.dbo.plansatirada
		 --where mjesec=5 and godina=2019 and dandolaska>'2019-05-01' 


select firma,radnikid,ime,dan01,dan02,dan03,dan04,dan05,dan06,dan07,dan08,dan09,dan10,dan11,dan12,dan13,dan14,dan15,dan16,dan17,dan18,dan19,dan20,dan21,dan22,dan23,dan24,dan25,dan26,dan27,dan28,dan29,dan30,dan31
from rfind.dbo.plansatirada2
where mjesec=5 and godina=2019
and mt=702