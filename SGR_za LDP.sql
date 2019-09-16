USE FeroApp
  & " select  x3.narucitelj Grupacija,sum(x3.kolicinaFx) KolicinaFx,0 TezinaFx, sum(x3.kolicinaloan) KolicinaLoan,0 Tezinaloan ,  sum(UkupnoFx_EUR) as  KnFX, sum(UkupnoL_EUR ) KnLoan "_
  & " from(select x2.narucitelj Narucitelj,case when x2.vlasnistvofx=1 then sum(x2.spremnot_pro) else 0 end  KolicinaFX,case when vlasnistvofx=0 then sum(x2.spremnot_pro) else 0 end  KolicinaLoan, "_
  & " case when vlasnistvofx=1 then sum(x2.IznosMat+x2.IznosObr) else 0 end UkupnoFx_EUR,case when vlasnistvofx=0 then sum(x2.IznosObr) else 0 end  UkupnoL_EUR,'Tokareno' VrstaObrade "_
  & " from(SELECT *, "_
  & " ((x1.cijenamatkom*x1.spremnot_pro*x1.vlasnistvofx)/x1.omjerpro) as IznosMat,((x1.cijenamatkom*x1.spremnot_pro)/x1.omjerpro) as IznosLoanMat,(x1.SpremnoT_Pro*x1.CijenaTok) as IznosObr  "_
  & " from( select "_
  & " CAST((SELECT TOP 1 UlazRobe.CijenaKom FROM UlazRobe WHERE UlazRobe.ID_Mat = StanjeProizvodnjeList.ID_Mat AND UlazRobe.VlasnistvoFX = StanjeProizvodnjeList.VlasnistvoFX ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom,  "_
  & " CAST(ISNULL((SELECT CijenaObrada1 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTok,  "_
  & " ID_NarS, VrstaNar, RnZaCalcKolicine, Bazni_RN, ID_Mat, OmjerPro, Zavrsni_RN, ID_Par, Narucitelj, VlasnistvoFX, DatumIsporuke, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, ID_Pro_T, SpremnoT_Pro "_
  & " FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno') WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0) AND ZavrsnaObrada = 'Tokarenje' "_
  & " ) x1	) x2	group by x2.narucitelj,x2.VlasnistvoFX  "_
  & " union all "_
  & " select x2.narucitelj Narucitelj, case when x2.vlasnistvofx=1 then sum(x2.spremnot_pro+x2.SpremnoK_Pro ) else 0 end  KolicinaFX,case when x2.vlasnistvofx=0 then sum(x2.spremnot_pro+x2.SpremnoK_Pro ) else 0 end  KolicinaLoan,  "_
  & " case when vlasnistvofx=1 then sum(x2.IznosMat + x2.NedovrsenoMat  + x2.IznosObr + x2.NedovrsenoObr) else 0 end  UkupnoFx_EUR,  "_
  & " case when vlasnistvofx=0 then sum( x2.IznosObr + x2.NedovrsenoObr) else 0 end  UkupnoL_EUR,'Kaljeno' VrstaObrade "_
  & " from(select x1.*,( (x1.cijenaMatkom*x1.vlasnistvoFx*x1.spremnoK_pro)/x1.OmjerPro ) as IznosMat, ((x1.cijenaMatkom*(x1.spremnoK_pro+x1.spremnoT_pro))/x1.OmjerPro ) as MatLoan,  ((x1.cijenaTok+x1.cijenaKalj)*x1.spremnoK_pro) as IznosObr,((x1.CijenaMatKom*x1.SpremnoT_Pro*x1.VlasnistvoFX)/x1.omjerpro) as NedovrsenoMat,((x1.CijenaMatKom*x1.SpremnoT_Pro)/x1.omjerpro) as NedovrsenoMatL,(x1.CijenaTok*x1.SpremnoT_Pro) as NedovrsenoObr "_
  & " from(SELECT CAST((SELECT TOP 1 UlazRobe.CijenaKom FROM UlazRobe WHERE UlazRobe.ID_Mat = StanjeProizvodnjeList.ID_Mat AND UlazRobe.VlasnistvoFX = StanjeProizvodnjeList.VlasnistvoFX ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom,  "_
  & " CAST(ISNULL((SELECT CijenaObrada1 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTok,  "_
  & " CAST(ISNULL((SELECT CijenaObrada2 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaKalj,  "_
  & " ID_NarS, VrstaNar, RnZaCalcKolicine, Bazni_RN, ID_Mat, OmjerPro, Zavrsni_RN, ID_Par, Narucitelj, VlasnistvoFX, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, ID_Pro_T, SpremnoT_Pro,  "_
  & " RN_Kaljenje, ID_Pro_K, SpremnoK_Pro, (SELECT NarudzbeSta.DatumIsporuke FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.RN_Kaljenje) AS DatumIsporuke  "_
  & " FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno') WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0) AND ZavrsnaObrada = 'Kaljenje' ) x1 	)x2	group by x2.narucitelj,x2.VlasnistvoFX "_
  & " union all "_
  & " select x2.narucitelj Narucitelj, case when x2.vlasnistvofx=1 then sum(x2.spremnoK_pro+x2.SpremnoTT_Pro ) else 0 end  KolicinaFX,case when vlasnistvofx=0 then sum(x2.spremnott_pro+x2.SpremnoK_Pro) else 0 end  KolicinaLoan, "_
  & " case when vlasnistvofx=1 then sum(x2.IznosMat + x2.NedovrsenoMat  + x2.IznosObr + x2.NedovrsenoIznosObr ) else 0 end  UkupnoFx_EUR,   "_
  & " case when vlasnistvofx=0 then sum(x2.IznosObr + x2.NedovrsenoIznosObr ) else 0 end  UkupnoL_EUR,'TvrdoTokarenje' VrstaObrade "_
  & " from( select x1.*,((x1.cijenaMatkom*x1.vlasnistvoFx*x1.spremnoTT_pro)/x1.OmjerPro ) as IznosMat, "_
  & " ((x1.cijenaMatkom*x1.spremnoTT_pro)/x1.OmjerPro ) as MatLoan,((x1.cijenaTok+x1.cijenaKalj+x1.CijenaTT)*x1.spremnoTT_pro) as IznosObr,((x1.SpremnoT_Pro+x1.SpremnoK_Pro)*x1.CijenaMatKom*x1.VlasnistvoFX) as NedovrsenoMat, "_
  & " ((x1.SpremnoT_Pro+x1.SpremnoK_Pro)*x1.CijenaMatKom*x1.VlasnistvoFX) as NedovrsenoMatL,((x1.cijenaTok*x1.SpremnoT_Pro)+(x1.cijenaKalj+x1.CijenaTok)*(x1.SpremnoK_Pro)) as NedovrsenoIznosObr "_
  & " from( SELECT CAST((SELECT TOP 1 UlazRobe.CijenaKom FROM UlazRobe WHERE UlazRobe.ID_Mat = StanjeProizvodnjeList.ID_Mat AND UlazRobe.VlasnistvoFX = StanjeProizvodnjeList.VlasnistvoFX ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom,  "_
  & " CAST(ISNULL((SELECT CijenaObrada1 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTok,  "_
  & " CAST(ISNULL((SELECT CijenaObrada2 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaKalj,  "_
  & " CAST(ISNULL((SELECT CijenaObrada3 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTT,  "_
  & " ID_NarS, VrstaNar, RnZaCalcKolicine, Bazni_RN, ID_Mat, OmjerPro, Zavrsni_RN, ID_Par, Narucitelj, VlasnistvoFX, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, ID_Pro_T, SpremnoT_Pro,  "_
  & " RN_Kaljenje, ID_Pro_K, SpremnoK_Pro, RN_TvrdoTokarenje, ID_Pro_TT, SpremnoTT_Pro, (SELECT NarudzbeSta.DatumIsporuke FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.RN_TvrdoTokarenje) AS DatumIsporuke  "_
  & " FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno') WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0) AND ZavrsnaObrada = 'Tvrdo tokarenje') x1 )x2 "_
  & " group by x2.narucitelj,x2.VlasnistvoFX "_
  & " union all "_
  & " SELECT Narucitelj Narucitelj, case when x2.vlasnistvofx=1 then sum(x2.spremnot_pro) else 0 end  KolicinaFX,case when vlasnistvofx=0 then sum(x2.spremnot_pro) else 0 end  KolicinaLoan, "_
  & " case when vlasnistvofx=1 then sum(x2.cijenaprokom * x2.Spremnot_pro ) else 0 end  UkupnoFx_EUR, case when vlasnistvofx=0 then sum(x2.cijenaprokom * x2.Spremnot_pro ) else 0 end  UkupnoL_EUR, "_
  & " 'Valjèiæi' VrstaObrade from ( "_
  & " select cast((select NarudzbeSta.FakturnaCijena from NarudzbeSta WHERE BrojRN = StanjeProizvodnjeList.Bazni_RN) as float) as CijenaProKom,  "_
  & " ID_NarS,VrstaNar, VlasnistvoFX,Narucitelj,OrderNo, Bazni_RN, BaznaObrada, ZavrsnaObrada, ID_Pro_T, NapravljenoT_Pro, SpremnoT_Pro "_
  & " FROM StanjeProizvodnjeList('Valjcici', '') WHERE SpremnoT_Pro <> 0 ) x2 group by x2.narucitelj,x2.VlasnistvoFX ) x3 group by x3.narucitelj "_
