USE FeroApp

SELECT epv.brojrn, (SELECT PRO.NazivPro FROM Proizvodi PRO WHERE PRO.ID_Pro = EPV.ID_Pro) AS Pozicija, SUM(EPV.OtpadMaterijal) AS Otpad_mat, SUM(EPV.OtpadObrada) AS Otpad_obrada 
       FROM EvidencijaProizvodnjeView EPV 
       WHERE year(EPV.Datum)=2017 
             AND EPV.BrojRN IN(SELECT NS.BrojRN FROM NarudzbeSta NS WHERE NS.Obrada1 = 0 AND NS.Obrada2 = 1) 
			 and (otpadmaterijal>0 or otpadobrada>0)
       GROUP BY epv.datum,EPV.BrojRN, EPV.ID_Pro 

--


use feroapp
SELECT m.NazivMatStari,epv.*,m.NazivMat, (SELECT PRO.NazivPro FROM Proizvodi PRO WHERE PRO.ID_Pro = EPV.ID_Pro) AS Pozicija
       FROM EvidencijaProizvodnjeView EPV 
	   left join Materijali m on m.ID_Mat=epv.id_mat
	   left join proizvodi p on p.ID_pro=epv.id_pro
       WHERE year(EPV.Datum) =2017 
             AND EPV.BrojRN IN(SELECT NS.BrojRN FROM NarudzbeSta NS WHERE NS.Obrada1 = 0 AND NS.Obrada2 = 1) 
			 and p.NazivPro like  '%809332%'			 
       order by datum
