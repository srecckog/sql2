use feroapp
sET DATEFORMAT dmy
             SELECT (CASE WHEN LEN(PomocniRadnik) > 6 THEN RIGHT(PomocniRadnik,LEN(PomocniRadnik)-6) END) AS Radnik,'1' as tip,
             (SELECT TOP 1 MT FROM FxSAP.dbo.PlanSatiRada WHERE RadnikID = (SELECT ID_Fink FROM Radnici WHERE ID_Radnika = EvidNormiRada.ID_Radnika) ORDER BY PsrID DESC) AS MT, EvidNormiRada.Hala
             FROM EvidNormiRada('2018-01-22', '2018-01-22') INNER JOIN Radnici ON EvidNormiRada.ID_Radnika2=Radnici.ID_Radnika
             WHERE EvidNormiRada.hala in ( '1','3') AND PomocniRadnik <> '' AND Vrsta NOT IN ('Šteler') AND Radnici.Kontrola = 0
             AND PomocniRadnik <> 'Pomoæ '
             Union
             SELECT Radnik,'2' tip,
             (SELECT TOP 1 MT FROM FxSAP.dbo.PlanSatiRada WHERE RadnikID = (SELECT ID_Fink FROM Radnici WHERE ID_Radnika = EvidNormiRada.ID_Radnika) ORDER BY PsrID DESC) AS MT, EvidNormiRada.Hala
             FROM EvidNormiRada('2018-01-22', '2018-01-22') LEFT JOIN Radnici
             ON EvidNormiRada.ID_Radnika=Radnici.ID_Radnika
             WHERE EvidNormiRada.hala in ( '1','3') AND Radnik <> '' AND Vrsta NOT IN ('Šteler') AND Radnici.Kontrola = 0
            Union
             SELECT Radnik,'3' tip, (SELECT TOP 1 MT FROM FxSAP.dbo.PlanSatiRada WHERE RadnikID = (SELECT ID_Fink FROM Radnici WHERE ID_Radnika = EvidNormiRada.ID_Radnika) ORDER BY PsrID DESC) AS MT, EvidNormiRada.Hala
             FROM EvidNormiRada('2018-01-22', '2018-01-22') WHERE hala in ('1','3') AND Vrsta = 'Šteler' ORDER BY tip,Radnik


			 use feroapp
			 select radnik,hala,smjena,satiradaradnika
			 from EvidNormiRada('2018-01-22','2018-01-22')
			 WHERE SATIRADARADNIKA=0
			 order by radnik

			 use feroapp
			 select *
			 from EvidNormiRada('2018-01-22','2018-01-22')
			 where satiradaradnika=0
			 order by radnik

			 select *
			 from radnici

			 SELECT * FROM FxSAP.dbo.PlanSatiRada
			 WHERE ime like '%ANTUNOVI%'
			 AND MJESEC=1 AND GODINA=2018