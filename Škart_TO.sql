use FeroApp

SELECT epv.Datum,epv.BrojSarze,EPV.BrojRN, (SELECT PRO.NazivPro FROM Proizvodi PRO WHERE PRO.ID_Pro = EPV.ID_Pro) AS Pozicija, SUM(EPV.OtpadMaterijal) AS Otpad_mat, SUM(EPV.OtpadObrada) AS Otpad_obrada 
       FROM EvidencijaProizvodnjeView EPV 
       WHERE year(EPV.Datum)= 2018 
             AND EPV.BrojRN IN 
			 
			 (
			 SELECT NS.BrojRN 
			 FROM NarudzbeSta NS 
			 WHERE NS.Obrada1 = 0 AND NS.Obrada2 = 1) 
			 and (epv.otpadmaterijal>0 or epv.otpadobrada>0)
       GROUP BY EPV.BrojRN, EPV.ID_Pro ,epv.datum,epv.brojsarze
	   order by datum