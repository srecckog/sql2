USE FeroApp

-- Stanje skladišta gotove robepo tipu vlasništva i naruèitelju
-- tokareno --
select  x3.naruèitelj Grupacija,sum(x3.kolicinaFx) KolicinaFx,0 TezinaFx, sum(x3.kolicinaloan) KolicinaLoan,0 Tezinaloan ,  sum(UkupnoFx_EUR) as  KnFX, sum(UkupnoL_EUR ) KnLoan
from(
select x2.narucitelj Naruèitelj,
case when x2.vlasnistvofx=1 then sum(x2.spremnot_pro) else 0 end  KolicinaFX,
case when vlasnistvofx=0 then sum(x2.spremnot_pro) else 0 end  KolicinaLoan,

case when vlasnistvofx=1 then sum(x2.IznosMat+x2.IznosObr) else 0 end UkupnoFx_EUR,  -- ukupno dovrseno+neodvrseno fx ili L
case when vlasnistvofx=0 then sum(x2.IznosObr) else 0 end  UkupnoL_EUR,
'Tokareno' VrstaObrade
from(

SELECT *,
((x1.cijenamatkom*x1.spremnot_pro*x1.vlasnistvofx)/x1.omjerpro) as IznosMat,((x1.cijenamatkom*x1.spremnot_pro)/x1.omjerpro) as IznosLoanMat,(x1.SpremnoT_Pro*x1.CijenaTok) as IznosObr 
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
	group by x2.narucitelj,x2.VlasnistvoFX 
	--ORDER BY Narucitelj,
-- kaljeno --
union all

--select  x3.naruèitelj,sum(x3.kolicinaFx) KolicinaFx,sum(x3.kolicinaloan) KolicinaLoan,(sum(x3.UkupnoDovrseno_EUR)+sum(x3.UkupnoNedovrseno_EUR)) UkupnaVrijednost
--from(
select x2.narucitelj Naruèitelj, 
case when x2.vlasnistvofx=1 then sum(x2.spremnot_pro+x2.SpremnoK_Pro ) else 0 end  KolicinaFX,
case when x2.vlasnistvofx=0 then sum(x2.spremnot_pro+x2.SpremnoK_Pro ) else 0 end  KolicinaLoan, 

--case when vlasnistvofx=0 then sum(x2.MatLoan) else 0 end  MatLoan,
--case when vlasnistvofx=1 then sum(x2.IznosMat) else 0 end  MatFx,

--sum(x2.Iznosmat+x2.IznosObr) as UkupnoDovrseno_EUR , 
--sum(x2.NeodvrsenoMat+NedovrsenoObr) as UkupnoNedovrseno_EUR, 

case when vlasnistvofx=1 then sum(x2.IznosMat + x2.NedovrsenoMat  + x2.IznosObr + x2.NedovrsenoObr) else 0 end  UkupnoFx_EUR,  -- ukupno dovrseno+neodvrseno fx ili L
case when vlasnistvofx=0 then sum( x2.IznosObr + x2.NedovrsenoObr) else 0 end  UkupnoL_EUR,

--sum(x2.Iznosmat+x2.IznosObr+x2.NeodvrsenoMat+NedovrsenoObr) Ukupno_EUR,
'Kaljeno' VrstaObrade
from(
select x1.*,( (x1.cijenaMatkom*x1.vlasnistvoFx*x1.spremnoK_pro)/x1.OmjerPro ) as IznosMat, ((x1.cijenaMatkom*(x1.spremnoK_pro+x1.spremnoT_pro))/x1.OmjerPro ) as MatLoan,  ((x1.cijenaTok+x1.cijenaKalj)*x1.spremnoK_pro) as IznosObr,((x1.CijenaMatKom*x1.SpremnoT_Pro*x1.VlasnistvoFX)/x1.omjerpro) as NedovrsenoMat,((x1.CijenaMatKom*x1.SpremnoT_Pro)/x1.omjerpro) as NedovrsenoMatL,(x1.CijenaTok*x1.SpremnoT_Pro) as NedovrsenoObr
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
union all
-- tvrdo tokareno --
--select  x3.naruèitelj,sum(x3.kolicinaFx) KolicinaFx,sum(x3.kolicinaloan) KolicinaLoan,(sum(x3.UkupnoDovrseno_EUR)+sum(x3.UkupnoNedovrseno_EUR)) UkupnaVrijednost
--from(
select x2.narucitelj Naruèitelj,  
case when x2.vlasnistvofx=1 then sum(x2.spremnoK_pro+x2.SpremnoTT_Pro ) else 0 end  KolicinaFX,
case when vlasnistvofx=0 then sum(x2.spremnott_pro+x2.SpremnoK_Pro) else 0 end  KolicinaLoan,
--sum(x2.Iznosmat+x2.IznosObr) UkupnoDovrseno_EUR ,
--sum(NedovrsenoMat+NedovrsenoIznosObr) UkupnoNedovrseno_EUR,
--sum(x2.Iznosmat+x2.IznosObr+NedovrsenoMat+NedovrsenoIznosObr) Ukupno_EUR,

case when vlasnistvofx=1 then sum(x2.IznosMat + x2.NedovrsenoMat  + x2.IznosObr + x2.NedovrsenoIznosObr ) else 0 end  UkupnoFx_EUR,  -- ukupno dovrseno+neodvrseno fx ili L
case when vlasnistvofx=0 then sum(x2.IznosObr + x2.NedovrsenoIznosObr ) else 0 end  UkupnoL_EUR,

'TvrdoTokarenje' VrstaObrade
from(
select x1.*,((x1.cijenaMatkom*x1.vlasnistvoFx*x1.spremnoTT_pro)/x1.OmjerPro ) as IznosMat,
((x1.cijenaMatkom*x1.spremnoTT_pro)/x1.OmjerPro ) as MatLoan,
((x1.cijenaTok+x1.cijenaKalj+x1.CijenaTT)*x1.spremnoTT_pro) as IznosObr,
((x1.SpremnoT_Pro+x1.SpremnoK_Pro)*x1.CijenaMatKom*x1.VlasnistvoFX) as NedovrsenoMat,
((x1.SpremnoT_Pro+x1.SpremnoK_Pro)*x1.CijenaMatKom*x1.VlasnistvoFX) as NedovrsenoMatL,
((x1.cijenaTok*x1.SpremnoT_Pro)+(x1.cijenaKalj+x1.CijenaTok)*(x1.SpremnoK_Pro)) as NedovrsenoIznosObr
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
union all
-- valjèiæi --
-- tvrdo tokareno --
--select  x3.naruèitelj,sum(x3.kolicinaFx) KolicinaFx,sum(x3.kolicinaloan) KolicinaLoan,(sum(x3.UkupnoDovrseno_EUR)+sum(x3.UkupnoNedovrseno_EUR)) UkupnaVrijednost
--from(
SELECT Narucitelj Naruèitelj, 
case when x2.vlasnistvofx=1 then sum(x2.spremnot_pro) else 0 end  KolicinaFX,
case when vlasnistvofx=0 then sum(x2.spremnot_pro) else 0 end  KolicinaLoan,



--sum((x2.cijenaprokom * x2.Spremnot_pro)) as UkupnoDovrseno_EUR, 
--0 UkupnoNedovrseno_EUR,
--sum(x2.cijenaprokom * x2.Spremnot_pro) Ukupno_EUR, 
case when vlasnistvofx=1 then sum(x2.cijenaprokom * x2.Spremnot_pro ) else 0 end  UkupnoFx_EUR,  -- ukupno dovrseno+neodvrseno fx ili L
case when vlasnistvofx=0 then sum(x2.cijenaprokom * x2.Spremnot_pro ) else 0 end  UkupnoL_EUR,

'Valjèiæi' VrstaObrade
from (
select
cast((select NarudzbeSta.FakturnaCijena from NarudzbeSta WHERE BrojRN = StanjeProizvodnjeList.Bazni_RN) as float) as CijenaProKom, 
ID_NarS,
VrstaNar, 
VlasnistvoFX,
Narucitelj,
OrderNo, Bazni_RN, BaznaObrada, ZavrsnaObrada, ID_Pro_T, NapravljenoT_Pro, SpremnoT_Pro
FROM StanjeProizvodnjeList('Valjcici', '') 
WHERE SpremnoT_Pro <> 0
) x2
group by x2.narucitelj,x2.VlasnistvoFX
) x3
group by x3.naruèitelj
-----------------


----------------

USE FeroApp

-- Stanje skladišta gotove robe po naruèitelju
-- tokareno --

select x3.naruèitelj Kunde,sum(x3.ukupno_eur) Gesamt
from (

select x2.narucitelj Naruèitelj, sum(x2.Iznosmat+x2.IznosObr) UkupnoDovrseno_EUR, 0 UkupnoNedovrseno_EUR,sum(x2.Iznosmat+x2.IznosObr) Ukupno_EUR, 'Tokareno' VrstaObrade
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
	group by narucitelj
	--ORDER BY Narucitelj,

-- kaljeno --
union all

select x2.narucitelj Naruèitelj, sum(x2.Iznosmat+x2.IznosObr) as UkupnoDovrseno_EUR , sum(x2.NeodvrsenoMat+NedovrsenoObr) as UkupnoNedovrseno_EUR, sum(x2.Iznosmat+x2.IznosObr+x2.NeodvrsenoMat+NedovrsenoObr) Ukupno_EUR,'Kaljeno' VrstaObrade
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

union all

-- tvrdo tokareno --
select x2.narucitelj Naruèitelj, sum(x2.Iznosmat+x2.IznosObr) UkupnoDovrseno_EUR ,sum(NedovrsenoMat+NedovrsenoIznosObr) UkupnoNedovrseno_EUR,sum(x2.Iznosmat+x2.IznosObr+NedovrsenoMat+NedovrsenoIznosObr) Ukupno_EUR,'TvrdoTokarenje' VrstaObrade
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
	group by x2.narucitelj

--	ORDER BY Narucitelj

union all

-- valjèiæi --

SELECT Narucitelj, sum((x1.cijenaprokom * x1.Spremnot_pro)) as UkupnoDovrseno_EUR, 0 UkupnoNedovrseno_EUR,sum(x1.cijenaprokom * x1.Spremnot_pro) Ukupno_EUR, 'Valjèiæi' VrstaObrade
from (
select
cast((select NarudzbeSta.FakturnaCijena from NarudzbeSta WHERE BrojRN = StanjeProizvodnjeList.Bazni_RN) as float) as CijenaProKom, 
ID_NarS,
VrstaNar, 
VlasnistvoFX,
Narucitelj,
OrderNo, Bazni_RN, BaznaObrada, ZavrsnaObrada, ID_Pro_T, NapravljenoT_Pro, SpremnoT_Pro
FROM StanjeProizvodnjeList('Valjcici', '') 
WHERE SpremnoT_Pro <> 0
) x1
group by x1.narucitelj

)x3 
group by x3.naruèitelj

---
select *
FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno')
wHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0)
AND ZavrsnaObrada = 'Tokarenje'