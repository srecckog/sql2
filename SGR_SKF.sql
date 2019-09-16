
DECLARE @TmpGodina smallint, @TmpKvartal tinyint,@dat1 date;

SET @TmpGodina = year( @dat1) ;

SET @TmpKvartal = datepart(q, @dat1) ;

WITH MyTmpTable1 AS(
SELECT SPL.ID_Par, SPL.Narucitelj, SPL.VrstaNar, SPL.VlasnistvoFX, SPL.Bazni_RN, SPL.Zavrsni_RN, SPL.ZavrsnaObrada, SPL.ID_Mat, SPL.OmjerPro, 
       (CASE SPL.ZavrsnaObrada WHEN 'Obrada #5' THEN SPL.ID_Pro_O5 WHEN 'Brusenje' THEN SPL.ID_Pro_BR WHEN 'Tvrdo tokarenje' THEN SPL.ID_Pro_TT WHEN 'Kaljenje' THEN SPL.ID_Pro_K ELSE SPL.ID_Pro_T END) AS ID_Pro, 
       (CASE SPL.ZavrsnaObrada WHEN 'Obrada #5' THEN SPL.SpremnoO5_Pro WHEN 'Brusenje' THEN SPL.SpremnoBR_Pro WHEN 'Tvrdo tokarenje' THEN SPL.SpremnoTT_Pro WHEN 'Kaljenje' THEN SPL.SpremnoK_Pro ELSE SPL.SpremnoT_Pro END) AS Spremno_kom 
       FROM feroapp.dbo.StanjeProizvodnjeList('*', 'Neisporuceno') SPL),
MyTmpTable2 AS(
SELECT *, 
       (SELECT TOP 1 FC.FakturnaCijena FROM (SELECT CAST((CASE @TmpKvartal WHEN 1 THEN FCP.CijenaProQ1 WHEN 2 THEN FCP.CijenaProQ2 WHEN 3 THEN FCP.CijenaProQ3 ELSE FCP.CijenaProQ4 END) AS float) AS FakturnaCijena FROM feroapp.dbo.FakturneCijeneProizvoda FCP WHERE FCP.Godina = @TmpGodina AND FCP.ID_Pro_Kup = (SELECT PRO.ID_Pro_Kup FROM feroapp.dbo.Proizvodi PRO WHERE PRO.ID_Pro = MTT1.ID_Pro) AND FCP.ID_Mat_Dob = (SELECT MAT.ID_Mat_Dob FROM feroapp.dbo.Materijali MAT WHERE MAT.ID_Mat = MTT1.ID_Mat)
                                                                     UNION ALL
                                                                     SELECT CAST((CASE @TmpKvartal WHEN 1 THEN FCP.CijenaProQ1 WHEN 2 THEN FCP.CijenaProQ2 WHEN 3 THEN FCP.CijenaProQ3 ELSE FCP.CijenaProQ4 END) AS float) AS FakturnaCijena FROM feroapp.dbo.FakturneCijeneProizvoda FCP WHERE FCP.Godina = @TmpGodina AND FCP.ID_Pro_Kup = (SELECT PRO.ID_Pro_Kup FROM feroapp.dbo.Proizvodi PRO WHERE PRO.ID_Pro = MTT1.ID_Pro)) FC) AS FakturnaCijena
       FROM MyTmpTable1 MTT1 WHERE Spremno_kom > 0) 


--select id_par,nazivpro,sum(spremno_kom) kom,cijenaobrade,cijenamat_kom,vlasnistvofx	   
--from (
--SELECT p.NazivPro,mtt2.ID_Par, MTT2.Narucitelj, MTT2.VrstaNar, MTT2.VlasnistvoFX, MTT2.Bazni_RN, MTT2.Zavrsni_RN, MTT2.ZavrsnaObrada, MTT2.ID_Mat, MTT2.ID_Pro, MTT2.Spremno_kom, (CASE WHEN ISNULL(NS.FakturnaCijena, 0) = 0 THEN MTT2.FakturnaCijena ELSE CAST(NS.FakturnaCijena AS float) END) AS FakturnaCijena, 
--       ((ISNULL(NS.Obrada1, 0) * ISNULL(NS.CijenaObrada1, 0)) + (ISNULL(NS.Obrada2, 0) * ISNULL(NS.CijenaObrada2, 0)) + (ISNULL(NS.Obrada3, 0) * ISNULL(NS.CijenaObrada3, 0)) + (ISNULL(NS.Obrada4, 0) * ISNULL(NS.CijenaObrada4, 0)) + (ISNULL(NS.Obrada5, 0) * ISNULL(NS.CijenaObrada5, 0))) AS CijenaObrade, 
--       (SELECT TOP 1 CAST(ULR.CijenaKom / MTT2.OmjerPro AS float) FROM feroapp.dbo.UlazRobe ULR WHERE ULR.ID_MAT = MTT2.ID_Mat ORDER BY ULR.ID_ULR DESC) AS CijenaMat_kom 
--       FROM MyTmpTable2 MTT2 
--             LEFT JOIN feroapp.dbo.NarudzbeSta NS ON MTT2.Bazni_RN = NS.BrojRN 
--			 left join feroapp.dbo.proizvodi p on p.id_pro=mtt2.id_pro
--       WHERE MTT2.VrstaNar IN('Prsteni', 'Zupcanici', 'Kucista', 'Valjcici')  
--	   and id_par=8752
--	   ) x1
--	   group by nazivpro,CijenaObrade,id_par,vlasnistvofx,cijenamat_kom


select id_par,sum(spremno_kom) komada,sum(spremno_kom*cijena) vrijednost,vrstanar,vlasnistvofx
from(
select x1.id_par,vrstanar,x1.spremno_kom,isnull(x1.fakturnacijena,x1.vlasnistvofx*x1.cijenamat_kom+x1.cijenaobrade) cijena,x1.VlasnistvoFX
from (

SELECT MTT2.ID_Par, MTT2.Narucitelj, MTT2.VrstaNar, MTT2.VlasnistvoFX, MTT2.Bazni_RN, MTT2.Zavrsni_RN, MTT2.ZavrsnaObrada, MTT2.ID_Mat, MTT2.ID_Pro, MTT2.Spremno_kom, (CASE WHEN ISNULL(NS.FakturnaCijena, 0) = 0 THEN MTT2.FakturnaCijena ELSE CAST(NS.FakturnaCijena AS float) END) AS FakturnaCijena, 
       ((ISNULL(NS.Obrada1, 0) * ISNULL(NS.CijenaObrada1, 0)) + (ISNULL(NS.Obrada2, 0) * ISNULL(NS.CijenaObrada2, 0)) + (ISNULL(NS.Obrada3, 0) * ISNULL(NS.CijenaObrada3, 0)) + (ISNULL(NS.Obrada4, 0) * ISNULL(NS.CijenaObrada4, 0)) + (ISNULL(NS.Obrada5, 0) * ISNULL(NS.CijenaObrada5, 0))) AS CijenaObrade, 
       (SELECT TOP 1 CAST(ULR.CijenaKom / MTT2.OmjerPro AS float) FROM feroapp.dbo.UlazRobe ULR WHERE ULR.ID_MAT = MTT2.ID_Mat ORDER BY ULR.ID_ULR DESC) AS CijenaMat_kom 
       FROM MyTmpTable2 MTT2 
             LEFT JOIN feroapp.dbo.NarudzbeSta NS ON MTT2.Bazni_RN = NS.BrojRN 
       WHERE MTT2.VrstaNar IN('Prsteni', 'Zupcanici', 'Kucista', 'Valjcici')  ) x1
	   ) x2
	   group by id_par,vrstanar,vlasnistvofx