USE FeroApp

-- tokareno --

select x2.narucitelj, vlasnistvoFX, sum(x2.Iznosmat+x2.IznosObr) UkupnoTok
from(

SELECT *,( (x1.cijenamatkom*x1.spremnot_pro*x1.vlasnistvofx)/x1.omjerpro) as IznosMat,(x1.SpremnoT_Pro*x1.CijenaTok) as IznosObr
from
( 
select
    CAST((SELECT TOP 1 UlazRobe.CijenaKom FROM UlazRobe WHERE UlazRobe.ID_Mat = StanjeProizvodnjeList.ID_Mat AND UlazRobe.VlasnistvoFX = StanjeProizvodnjeList.VlasnistvoFX ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom, 
	CAST(ISNULL((SELECT CijenaObrada1 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTok, 
	ID_NarS, VrstaNar, RnZaCalcKolicine, Bazni_RN, ID_Mat, OmjerPro, Zavrsni_RN, ID_Par, Narucitelj, VlasnistvoFX, DatumIsporuke, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, ID_Pro_T, SpremnoT_Pro

	FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno')
	WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0)
	AND ZavrsnaObrada = 'Tokarenje'
	) x1
	) x2
	group by narucitelj,vlasnistvoFX
	--ORDER BY Narucitelj,

-- kaljeno --

select x2.narucitelj, vlasnistvoFX, sum(x2.Iznosmat+x2.IznosObr+x2.NeodvrsenoMat+NedovrsenoObr) UkupnoKalj
from(
select x1.*,((x1.cijenaMatkom*x1.vlasnistvoFx*x1.spremnoK_pro)/x1.OmjerPro ) as IznosMat,((x1.cijenaTok+x1.cijenaKalj)*x1.spremnoK_pro) as IznosObr,((x1.CijenaMatKom*x1.SpremnoT_Pro*x1.VlasnistvoFX)/x1.omjerpro) as NeodvrsenoMat,(x1.CijenaTok*x1.SpremnoT_Pro) as NedovrsenoObr
from(
SELECT CAST((SELECT TOP 1 UlazRobe.CijenaKom FROM UlazRobe WHERE UlazRobe.ID_Mat = StanjeProizvodnjeList.ID_Mat AND UlazRobe.VlasnistvoFX = StanjeProizvodnjeList.VlasnistvoFX ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom, 
	CAST(ISNULL((SELECT CijenaObrada1 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTok, 
	CAST(ISNULL((SELECT CijenaObrada2 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaKalj, 
	ID_NarS, VrstaNar, RnZaCalcKolicine, Bazni_RN, ID_Mat, OmjerPro, Zavrsni_RN, ID_Par, Narucitelj, VlasnistvoFX, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, ID_Pro_T, SpremnoT_Pro, 
	RN_Kaljenje, ID_Pro_K, SpremnoK_Pro, (SELECT NarudzbeSta.DatumIsporuke FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.RN_Kaljenje) AS DatumIsporuke 
	FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno')
	WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0)
	AND ZavrsnaObrada = 'Kaljenje'
	) x1
	)x2
	group by x2.narucitelj,x2.VlasnistvoFX
--	ORDER BY Narucitelj

-- tvrdo tokareno --
select x2.narucitelj, vlasnistvoFX, sum(x2.Iznosmat+x2.IznosObr+NedovrsenoMat+NedovrsenoIznosObr) UkupnoKalj
from(
select x1.*,((x1.cijenaMatkom*x1.vlasnistvoFx*x1.spremnoTT_pro)/x1.OmjerPro ) as IznosMat,((x1.cijenaTok+x1.cijenaKalj+x1.CijenaTT)*x1.spremnoTT_pro) as IznosObr,
((x1.SpremnoT_Pro+x1.SpremnoK_Pro)*x1.CijenaMatKom*x1.VlasnistvoFX) as NedovrsenoMat,((x1.cijenaTok*x1.SpremnoT_Pro)+(x1.cijenaKalj+x1.CijenaTok)*(x1.SpremnoK_Pro)) as NedovrsenoIznosObr
from(

SELECT CAST((SELECT TOP 1 UlazRobe.CijenaKom FROM UlazRobe WHERE UlazRobe.ID_Mat = StanjeProizvodnjeList.ID_Mat AND UlazRobe.VlasnistvoFX = StanjeProizvodnjeList.VlasnistvoFX ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom, 
	CAST(ISNULL((SELECT CijenaObrada1 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTok, 
	CAST(ISNULL((SELECT CijenaObrada2 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaKalj, 
	CAST(ISNULL((SELECT CijenaObrada3 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTT, 
	ID_NarS, VrstaNar, RnZaCalcKolicine, Bazni_RN, ID_Mat, OmjerPro, Zavrsni_RN, ID_Par, Narucitelj, VlasnistvoFX, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, ID_Pro_T, SpremnoT_Pro, 
	RN_Kaljenje, ID_Pro_K, SpremnoK_Pro, RN_TvrdoTokarenje, ID_Pro_TT, SpremnoTT_Pro, (SELECT NarudzbeSta.DatumIsporuke FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.RN_TvrdoTokarenje) AS DatumIsporuke 
	FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno')
	WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0)
	AND ZavrsnaObrada = 'Tvrdo tokarenje'
	) x1 
	)x2
	group by x2.narucitelj,x2.VlasnistvoFX

--	ORDER BY Narucitelj

-- valjèiæi --

SELECT sum((x1.cijenaprokom * x1.Spremnot_pro)) as Iznos
from (
select
cast((select NarudzbeSta.FakturnaCijena from NarudzbeSta WHERE BrojRN = StanjeProizvodnjeList.Bazni_RN) as float) as CijenaProKom, 
ID_NarS,
VrstaNar, 
OrderNo, Bazni_RN, BaznaObrada, ZavrsnaObrada, ID_Pro_T, NapravljenoT_Pro, SpremnoT_Pro
FROM StanjeProizvodnjeList('Valjcici', '') 
WHERE SpremnoT_Pro <> 0
) x1


----------

select *
from StanjeProizvodnjeList('prsteni','Neisporuceno')
WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0)
order by narucitelj


