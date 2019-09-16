    declare @dat1 date
declare @dat2 date
set @dat1='2018-01-03'
set @dat2='2018-01-03';

	
	WITH MyTmpTable1 AS(
      SELECT enz.hala,NarZ.ID_Par,ens.linija, ENZ.Datum, (CASE Proizvodi.ZavrsnaObrada WHEN 'Tokarenje' THEN ENS.ObradaA WHEN 'Glodanje' THEN ENS.ObradaB WHEN 'Bušenje' THEN ENS.ObradaC ELSE ENS.ObradaA END) AS ZavrsnaObrada, 
        Proizvodi.ID_Pro, Proizvodi.VrstaPro, CAST(ISNULL(ENS.KolicinaOK, 0) AS int) AS KolicinaOK, ENS.BrojRN,nars.CijenaObrada1,CijenaObrada2,CijenaObrada3
        FROM feroapp.dbo.EvidencijaNormiSta ENS 
            INNER JOIN feroapp.dbo.EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
            INNER JOIN feroapp.dbo.NarudzbeSta NarS ON ENS.BrojRN = NarS.BrojRN 
            INNER JOIN feroapp.dbo.NarudzbeZag NarZ ON NarS.ID_NarZ = NarZ.ID_NarZ 
            INNER JOIN feroapp.dbo.Proizvodi ON NarS.ID_Pro = Proizvodi.ID_Pro 
        WHERE ENZ.Datum BETWEEN @Dat1 AND @Dat2
            AND NarS.BazniRN = 1 AND NarS.Obrada1 = 1 )


		select hala,sum(kolicinaok) kolicina,sum(kolicinaok*cijenaobrada1) vrijednost,vrstapro,NazivPar kupac,'TOK' vo
			from mytmptable1 t1
			left join feroapp.dbo.partneri p on p.ID_Par=t1.ID_Par
			where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3')
			group by hala,nazivpar,vrstapro
			union all
			select hala,sum(kolicinaok) kolicina,sum(kolicinaok*cijenaobrada2) vrijednost,vrstapro,NazivPar kupac,'DO' vo
			from mytmptable1 t1
			left join feroapp.dbo.partneri p on p.ID_Par=t1.ID_Par
			where linija in ('HURCO','VC510','GT600-1','GT600-2','GT600-3')
			group by hala,nazivpar,vrstapro
			order by nazivpar