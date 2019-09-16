USE FeroApp

-- tokareno --
select sum(cijenatok*spremnot_pro) vrijednost,id_par
from (
SELECT CAST((SELECT TOP 1 UlazRobe.CijenaKom FROM UlazRobe WHERE UlazRobe.ID_Mat = StanjeProizvodnjeList.ID_Mat AND UlazRobe.VlasnistvoFX = StanjeProizvodnjeList.VlasnistvoFX ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom, 
	CAST(ISNULL((SELECT CijenaObrada1 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTok, 
	ID_NarS, VrstaNar, RnZaCalcKolicine, Bazni_RN, ID_Mat, OmjerPro, Zavrsni_RN, ID_Par, Narucitelj, VlasnistvoFX, DatumIsporuke, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, ID_Pro_T, SpremnoT_Pro
	FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno')
	WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0)
	--and id_par=274
	--AND ZavrsnaObrada = 'Tokarenje'
	) x1
	group by id_par
	--ORDER BY Narucitelj