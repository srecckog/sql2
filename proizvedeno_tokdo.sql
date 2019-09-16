declare @Datum1 date, @Datum2 date
set @datum1 ='2017-11-19'
set @datum2 ='2017-11-19';

    WITH MyTmpTable1 AS(
      SELECT NarZ.ID_Par, ENZ.Datum,ens.linija, (CASE Proizvodi.ZavrsnaObrada WHEN 'Tokarenje' THEN ENS.ObradaA WHEN 'Glodanje' THEN ENS.ObradaB WHEN 'Bušenje' THEN ENS.ObradaC ELSE ENS.ObradaA END) AS ZavrsnaObrada, 
        Proizvodi.ID_Pro, Proizvodi.VrstaPro, CAST(ISNULL(ENS.KolicinaOK, 0) AS int) AS KolicinaOK, ENS.BrojRN 
        FROM EvidencijaNormiSta ENS 
            INNER JOIN EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
            INNER JOIN NarudzbeSta NarS ON ENS.BrojRN = NarS.BrojRN 
            INNER JOIN NarudzbeZag NarZ ON NarS.ID_NarZ = NarZ.ID_NarZ 
            INNER JOIN Proizvodi ON NarS.ID_Pro = Proizvodi.ID_Pro 
        WHERE ENZ.Datum BETWEEN @Datum1 AND @Datum2
            AND NarS.BazniRN = 1 AND NarS.Obrada1 = 1),
    MyTmpTable2 AS(
--      SELECT ID_Par, Datum, 'Norme' AS Vrsta, VrstaPro, CAST(SUM(KolicinaOK) AS int) AS Kolicina, 0 AS StrojnaObrada, 0 AS ToplinskaObrada ,CASE WHEN LINIJA IN ('HURCO','VC510','GT600-1','GT600-2','GT600-3') THEN 'TOK' ELSE 'DO' END TOK_DO
	  SELECT ID_Par, Datum, 'Norme' AS Vrsta, VrstaPro, CAST(SUM(KolicinaOK) AS int) AS Kolicina, 0 AS StrojnaObrada, 0 AS ToplinskaObrada ,linija 
	    FROM MyTmpTable1 
        WHERE ZavrsnaObrada = 1 
            AND ID_Pro IS NOT NULL
        GROUP BY ID_Par, Datum, VrstaPro ,linijA
      UNION ALL 
      SELECT NDV.ID_Par, FDV.DatumFakture, 'Fakture', Proizvodi.VrstaPro, CAST(SUM(ISNULL(KolicinaPro, 0)) AS int) AS Kolicina, 
		SUM((ISNULL(FDV.Obrada1 * FDV.CijenaObrada1, 0) + ISNULL(FDV.Obrada3 * FDV.CijenaObrada3, 0) + ISNULL(FDV.Obrada4 * FDV.CijenaObrada4, 0) + ISNULL(FDV.Obrada5 * FDV.CijenaObrada5, 0)) * FDV.KolicinaPro) AS StrojnaObrada, 
		SUM(ISNULL(FDV.Obrada2 * FDV.CijenaObrada2, 0) * FDV.KolicinaPro) AS ToplinskaObrada ,'TOK1' linija
        FROM FaktureDetaljnoView FDV
            INNER JOIN Proizvodi ON FDV.ID_Pro = Proizvodi.ID_Pro 
			INNER JOIN NarudzbeDetaljnoView NDV ON FDV.BrojRN = NDV.BrojRN 
        WHERE FDV.DatumFakture BETWEEN @Datum1 AND @Datum2
            AND FDV.VrstaTroska = 'Proizvod'
            AND FDV.ID_Pro IS NOT NULL
            AND FDV.Obrada1 = 1 
        GROUP BY NDV.ID_Par, FDV.DatumFakture, Proizvodi.VrstaPro)


		select *
		from mytmptable2


    SELECT MttPar.ID_Par, Partneri.NazivPar AS Kupac, MttPar.VrstaPro, 
      CAST(ISNULL((SELECT SUM(MttChi1.Kolicina) FROM MyTmpTable2 MttChi1 WHERE MttChi1.ID_Par = MttPar.ID_Par AND MttChi1.VrstaPro = MttPar.VrstaPro AND MttChi1.Vrsta = 'Norme' and mttchi1.linija NOT in ('HURCO','VC510','GT600-1','GT600-2','GT600-3')), 0) AS int) AS Proizvedeno_tok, 
	  CAST(ISNULL((SELECT SUM(MttChi3.Kolicina) FROM MyTmpTable2 MttChi3 WHERE MttChi3.ID_Par = MttPar.ID_Par AND MttChi3.VrstaPro = MttPar.VrstaPro AND MttChi3.Vrsta = 'Norme' AND MTTchi3.LINIJA in ('HURCO','VC510','GT600-1','GT600-2','GT600-3')), 0) AS int) AS Proizvedeno_DO,
      CAST(ISNULL((SELECT SUM(MttChi2.Kolicina) FROM MyTmpTable2 MttChi2 WHERE MttChi2.ID_Par = MttPar.ID_Par AND MttChi2.VrstaPro = MttPar.VrstaPro AND MttChi2.Vrsta = 'Fakture'), 0) AS int) AS Fakturirano, 
	  CAST(SUM(ISNULL(MttPar.StrojnaObrada, 0)) AS float) AS FakturiranoSO, CAST(SUM(ISNULL(MttPar.ToplinskaObrada, 0)) AS float) AS FakturiranoTO 
      FROM MyTmpTable2 MttPar 
          INNER JOIN Partneri ON MttPar.ID_Par = Partneri.ID_Par 
      GROUP BY MttPar.ID_Par, Partneri.NazivPar, MttPar.VrstaPro


	  select *
	  from proizvodi


	  SELECT NDV.ID_Par, FDV.DatumFakture, 'Fakture', Proizvodi.VrstaPro, CAST(SUM(ISNULL(KolicinaPro, 0)) AS int) AS Kolicina, 
		SUM((ISNULL(FDV.Obrada1 * FDV.CijenaObrada1, 0) + ISNULL(FDV.Obrada3 * FDV.CijenaObrada3, 0) + ISNULL(FDV.Obrada4 * FDV.CijenaObrada4, 0) + ISNULL(FDV.Obrada5 * FDV.CijenaObrada5, 0)) * FDV.KolicinaPro) AS StrojnaObrada, 
		SUM(ISNULL(FDV.Obrada2 * FDV.CijenaObrada2, 0) * FDV.KolicinaPro) AS ToplinskaObrada 
        FROM FaktureDetaljnoView FDV
            INNER JOIN Proizvodi ON FDV.ID_Pro = Proizvodi.ID_Pro 
			INNER JOIN NarudzbeDetaljnoView NDV ON FDV.BrojRN = NDV.BrojRN 
        WHERE FDV.DatumFakture BETWEEN '2017-11-19' AND '2017-11-19'
            AND FDV.VrstaTroska = 'Proizvod'
            AND FDV.ID_Pro IS NOT NULL
            AND FDV.Obrada1 = 1 
        GROUP BY NDV.ID_Par, FDV.DatumFakture, Proizvodi.VrstaPro
