use feroapp
select vrstapro,nazivpar,id_par,kratkinazivikupca,month(datumfakture) mjesec,sum(kolicina) kolicina
from (
SELECT FDV.ID_Par, PAR.NazivPar, FDV.DatumFakture, CAST(SUM(FDV.KolicinaPro) AS float) AS Kolicina,p.VrstaPro,par.KratkiNaziviKupca
                FROM FaktureDetaljnoView FDV 
                               LEFT JOIN Partneri PAR ON FDV.ID_Par = PAR.ID_Par 
                               LEFT JOIN VrsteFaktura VF ON FDV.VrstaFakture = VF.VrstaFakture 
							   left join proizvodi p on p.ID_Pro=fdv.ID_Pro
                WHERE FDV.DatumFakture >= '2018-01-01' and FDV.DatumFakture <= '2018-04-20'
                               AND VF.Export2Pantheon = 1 
                               AND FDV.KolicinaPro > 0 
                               AND FDV.ID_Ulp IS NOT NULL 
                GROUP BY FDV.ID_Par, PAR.NazivPar, FDV.DatumFakture ,p.VrstaPro,par.KratkiNaziviKupca
				) x1
				group by nazivpar,id_par,month(datumfakture),vrstapro,KratkiNaziviKupca
				order by nazivpar,id_par,month(datumfakture)
                

-- wupertal prsten
				select sum(kolicinapro)
				from (
				select p.VrstaPro,f.*
				from FaktureDetaljnoView f
				left join proizvodi p on p.ID_Pro=f.ID_Pro
				where  id_par=121274 and vrstapro='Prsten'
				and f.DatumFakture >= '2018-01-01' and f.DatumFakture <= '2018-01-31'
				)x1

-- valjci - svi				
				select sum(kolicinapro)
				from (
				select p.VrstaPro,f.*
				from FaktureDetaljnoView f
				left join proizvodi p on p.ID_Pro=f.ID_Pro
				where  vrstapro='Valjak'
				and f.DatumFakture >= '2018-04-01' and f.DatumFakture <= '2018-04-17'
				)x1



				select *
				from partneri
				where KratkiNaziviKupca!=''
				

-- naruèeno

USE FeroApp


select id_par,kupac,sum(kolicina),month(datumisporuke)
from (
SELECT NDV.ID_Par, (SELECT PAR.NazivPar FROM Partneri PAR WHERE PAR.ID_Par =
NDV.ID_Par) AS Kupac, NDV.DatumIsporuke, CAST(SUM(NDV.KolicinaNar) AS float) AS Kolicina
	FROM NarudzbeDetaljnoView NDV 
	WHERE NDV.DatumIsporuke BETWEEN '2018-01-01' AND '2018-04-20' 
		AND NDV.BazniRN = 1 
	GROUP BY NDV.ID_Par, NDV.DatumIsporuke
	) x1
	group by id_par,kupac,month(datumisporuke)