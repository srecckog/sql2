declare @datumod date='2019-05-01'
declare @datumdo date='2019-05-31';
WITH MyTmpTable1 AS (
		SELECT ENZ.Datum, ENZ.Smjena, ENZ.Hala, ENS.ID_ENS, ENS.ID_Radnika, ENS.Radnik AS Ime, RAD.ID_Fink, RAD.ID_Firme, (CASE WHEN ENS.Norma = 1 THEN ENS.KolicinaOK ELSE ENS.Norma END) AS Norma, ENS.KolicinaOK , case when (DATEDIFF(MINUTE, vrijemeod, vrijemedo)>=0) then DATEDIFF(MINUTE, vrijemeod, vrijemedo)  else (DATEDIFF(MINUTE, vrijemeod, vrijemedo)+1440) end   minuta
		FROM EvidencijaNormiSta ENS 
			LEFT JOIN EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
			LEFT JOIN Radnici RAD ON ENS.ID_Radnika = RAD.ID_Radnika 
		WHERE ENZ.Datum BETWEEN @DatumOd AND @DatumDo AND ISNULL(ENS.KolicinaOK, 0) <> 0 AND ISNULL(ENS.ID_Radnika, 0) <> 0 AND ISNULL(ENS.Norma, 0) <> 0 
		UNION		
		SELECT ENZ.Datum, ENZ.Smjena, ENZ.Hala, ENS.ID_ENS, ENS.ID_Radnika2, ENS.Radnik2 + ' (pr)' AS Ime, RAD.ID_Fink, RAD.ID_Firme, (CASE WHEN ENS.Norma = 1 THEN ENS.KolicinaOK ELSE ENS.Norma END) AS Norma, ENS.KolicinaOK , case when (DATEDIFF(MINUTE, vrijemeod, vrijemedo)>=0) then DATEDIFF(MINUTE, vrijemeod, vrijemedo)  else (DATEDIFF(MINUTE, vrijemeod, vrijemedo)+1440) end  minuta
		FROM EvidencijaNormiSta ENS 
			LEFT JOIN EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
			LEFT JOIN Radnici RAD ON ENS.ID_Radnika2 = RAD.ID_Radnika 
		WHERE ENZ.Datum BETWEEN @DatumOd AND @DatumDo AND ISNULL(ENS.KolicinaOK, 0) <> 0 AND ISNULL(ENS.ID_Radnika2, 0) <> 0 AND ISNULL(ENS.Norma, 0) <> 0), 
	MyTmpTable2 AS (
		SELECT MTT1.*, CAST((CAST((CAST(MTT1.KolicinaOK AS decimal(14,5)) / CAST(MTT1.Norma AS decimal(14,5))) AS decimal(13,4)) * 100) AS decimal(11,2)) AS Omjer FROM MyTmpTable1 MTT1) 

	SELECT MTT2.ID_Firme, MTT2.ID_Radnika, MTT2.ID_Fink, MTT2.Ime, MTT2.Datum, MTT2.Smjena, MTT2.Hala, MTT2.KolicinaOK AS 'Kolicina', Omjer AS 'RealizacijaPosto',minuta,Norma,case when (norma>0 and minuta>0) then (minuta/480)*norma else 0 end  'Planirano' --, case when (norma>0 and minuta>0) then (    MTT2.KolicinaOK/(minuta/480*norma)   ) else 0 end posto2 
		FROM MyTmpTable2 MTT2 


