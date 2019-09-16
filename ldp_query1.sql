	
Datum LDP-a: 
12.4.2017
... Hala:   Pretraži      Excel 

SELECT a.datum, a.hala, a.linija, a.smjena, a.ID_PRO, SUM(TekstCheck01) as kolikostelanja, (SELECT COUNT(*) FROM evidnormi(CONVERT(datetime, '12.4.2017', 104), CONVERT(datetime, '12.4.2017', 104), 0) where Hala='3' and linija=a.Linija and ID_Pro=a.id_pro GROUP BY datum, hala, linija, ID_PRO) AS zbroj, 
(SELECT TOP 1 SMJENA FROM evidnormi(CONVERT(datetime, '12.4.2017', 104), CONVERT(datetime, '12.4.2017', 104), 0) 
where Hala='3' and linija=a.Linija and ID_Pro=a.id_pro 
GROUP BY SMJENA ORDER BY SMJENA DESC) AS zbroj2 
FROM evidnormi(CONVERT(datetime, '12.4.2017', 104), CONVERT(datetime, '12.4.2017', 104), 0) a 
where Hala='3' 
GROUP BY a.datum, a.hala, a.linija, a.smjena, a.ID_PRO 
ORDER BY a.datum, a.hala, a.linija, a.smjena, kolikostelanja, zbroj, zbroj2


SELECT * FROM 
evidnormi(CONVERT(datetime, '12.4.2017', 104), CONVERT(datetime, '12.4.2017', 104), 0) 
where Hala='3' and linija='15' and ID_Pro='940956' 



GROUP BY datum, hala, linija, ID_PRO 