USE [FeroApp]
declare @Datum1 date, @Datum2 date
set @datum1='2018-04-01'
set @datum2='2018-04-30' ;


    WITH MyTmpTable1 AS(
       SELECT NarZ.ID_Par, ENZ.Datum, (CASE PRO.ZavrsnaPoprObrada WHEN PRO.VrstaObradeB THEN ENS.ObradaB WHEN PRO.VrstaObradeC THEN ENS.ObradaC WHEN PRO.VrstaObradeD THEN ENS.ObradaD WHEN PRO.VrstaObradeE THEN ENS.ObradaE WHEN PRO.VrstaObradeF THEN ENS.ObradaF WHEN PRO.VrstaObradeG THEN ENS.ObradaG WHEN PRO.VrstaObradeH THEN ENS.ObradaH WHEN PRO.VrstaObradeI THEN ENS.ObradaI ELSE ENS.ObradaA END) AS ZavrsnaObrada, 
        PRO.ID_Pro, PRO.VrstaPro, CAST(ISNULL(ENS.KolicinaOK, 0) AS int) AS KolicinaOK, ENS.BrojRN 
        FROM EvidencijaNormiSta ENS 
            INNER JOIN EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
            INNER JOIN NarudzbeSta NarS ON ENS.BrojRN = NarS.BrojRN 
            INNER JOIN NarudzbeZag NarZ ON NarS.ID_NarZ = NarZ.ID_NarZ 
            INNER JOIN Proizvodi PRO ON NarS.ID_Pro = PRO.ID_Pro 
        WHERE ENZ.Datum BETWEEN @Datum1 AND @Datum2
            AND NarS.BazniRN = 1 AND NarS.Obrada1 = 1),
    MyTmpTable2 AS(
      --SELECT ID_Par, Datum, 'Norme' AS Vrsta, VrstaPro, CAST(SUM(KolicinaOK) AS int) AS Kolicina, 0 AS StrojnaObrada, 0 AS ToplinskaObrada 
      --  FROM MyTmpTable1 
      --  WHERE ZavrsnaObrada = 1 
      --      AND ID_Pro IS NOT NULL
      --  GROUP BY ID_Par, Datum, VrstaPro
      --UNION ALL 
      SELECT NDV.ID_Par, FDV.DatumFakture,  PRO.VrstaPro, PRO.NazivPro,   CAST(ISNULL(KolicinaPro, 0) AS int) AS Kolicina, 
		(ISNULL(FDV.Obrada1 * FDV.CijenaObrada1, 0) + ISNULL(FDV.Obrada3 * FDV.CijenaObrada3, 0) + ISNULL(FDV.Obrada4 * FDV.CijenaObrada4, 0) + ISNULL(FDV.Obrada5 * FDV.CijenaObrada5, 0) * FDV.KolicinaPro) AS StrojnaObrada, 
		FDV.CijenaObrada2 AS ToplinskaObrada 
        FROM FaktureDetaljnoView FDV
            INNER JOIN Proizvodi PRO ON FDV.ID_Pro = PRO.ID_Pro 
			INNER JOIN NarudzbeDetaljnoView NDV ON FDV.BrojRN = NDV.BrojRN 
        WHERE FDV.DatumFakture BETWEEN @Datum1 AND @Datum2
            AND FDV.VrstaTroska = 'Proizvod'
            AND FDV.ID_Pro IS NOT NULL
            AND FDV.Obrada1 = 1 )
        --GROUP BY NDV.ID_Par, FDV.DatumFakture, PRO.VrstaPro,PRO.NazivPro,FDV.CijenaObrada1,FDV.CijenaObrada2,FDV.CijenaObrada3,FDV.CijenaObrada4,FDV.CijenaObrada5)

		
		SELECT t.*,p.NazivPar
		FROM MyTmpTable1 t
		left join partneri p on p.ID_Par=t.ID_Par		
		--where t.id_par=274



		SELECT t.id_par,p.NazivPar,t.DatumFakture,nazivpro,Kolicina,cast (strojnaobrada as varchar(15)) Cijena_strojne_obrade,cast( (kolicina*StrojnaObrada) as varchar(15))  Fakturirano_so,ToplinskaObrada as 'Cijena_ToplinskeObrade',cast( (kolicina*toplinskaObrada) as varchar(15)) FakturiranoTO
		FROM MyTmpTable2 t
		left join partneri p on p.ID_Par=t.ID_Par
		order by datumfakture
		--where t.id_par=274



		SELECT MttPar.ID_Par, Partneri.NazivPar AS Kupac, MttPar.VrstaPro, 
      CAST(ISNULL((SELECT MttChi1.Kolicina FROM MyTmpTable2 MttChi1 WHERE MttChi1.ID_Par = MttPar.ID_Par AND MttChi1.VrstaPro = MttPar.VrstaPro AND MttChi1.Vrsta = 'Norme'), 0) AS int) AS Proizvedeno, 
	  CAST(ISNULL((SELECT MttChi2.Kolicina FROM MyTmpTable2 MttChi2 WHERE MttChi2.ID_Par = MttPar.ID_Par AND MttChi2.VrstaPro = MttPar.VrstaPro AND MttChi2.Vrsta = 'Fakture'), 0) AS int) AS Fakturirano, 
	  CAST(ISNULL(MttPar.StrojnaObrada, 0) AS float) AS FakturiranoSO, 
	  CAST(ISNULL(MttPar.ToplinskaObrada, 0) AS float) AS FakturiranoTO 
      FROM MyTmpTable2 MttPar 
          INNER JOIN Partneri ON MttPar.ID_Par = Partneri.ID_Par 
      ORDER BY MttPar.ID_Par, Partneri.NazivPar, MttPar.VrstaPro



    SELECT MttPar.ID_Par, Partneri.NazivPar AS Kupac, MttPar.VrstaPro, 
      CAST(ISNULL((SELECT SUM(MttChi1.Kolicina) FROM MyTmpTable2 MttChi1 WHERE MttChi1.ID_Par = MttPar.ID_Par AND MttChi1.VrstaPro = MttPar.VrstaPro AND MttChi1.Vrsta = 'Norme'), 0) AS int) AS Proizvedeno, 
	  CAST(ISNULL((SELECT SUM(MttChi2.Kolicina) FROM MyTmpTable2 MttChi2 WHERE MttChi2.ID_Par = MttPar.ID_Par AND MttChi2.VrstaPro = MttPar.VrstaPro AND MttChi2.Vrsta = 'Fakture'), 0) AS int) AS Fakturirano, 
	  CAST(SUM(ISNULL(MttPar.StrojnaObrada, 0)) AS float) AS FakturiranoSO, CAST(SUM(ISNULL(MttPar.ToplinskaObrada, 0)) AS float) AS FakturiranoTO 
      FROM MyTmpTable2 MttPar 
          INNER JOIN Partneri ON MttPar.ID_Par = Partneri.ID_Par 
      GROUP BY MttPar.ID_Par, Partneri.NazivPar, MttPar.VrstaPro



	  select *
	  from NarudzbeSta
	  where BrojRN1='SONA/241/2018'

	  select *
	  from EVIDENCIJANORMIZAG
	  where BrojRN1='SONA/241/2018'