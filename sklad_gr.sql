  select grupacija,cast( kolicinafx as int) kolicinafx,cast( tezinafx as int) tezinafx,cast( kolicinaloan as int) kolicinaloan,cast( knfx as int) knfx,cast( knloan as int) knloan
  from(
  SELECT  Grupacija, SUM((CASE WHEN VlasnistvoFX = 1 THEN SaldoKolPro*1 ELSE 0 END)) AS KolicinaFX, SUM((CASE WHEN VlasnistvoFX = 1 THEN 0 ELSE 0 END)) AS TezinaFX, SUM((CASE WHEN VlasnistvoFX = 0 THEN SaldoKolPro*1 ELSE 0 END)) AS KolicinaLoan,
       SUM((CASE WHEN VlasnistvoFX = 0 THEN 0 ELSE 0 END)) AS TezinaLoan,
       SUM((CASE WHEN VlasnistvoFX = 1 THEN VrijednostPredatnice*1 ELSE 0 END)) AS KnFX,
       SUM((CASE WHEN VlasnistvoFX = 0 THEN VrijednostPredatnice*1 ELSE 0 END)) AS KnLoan
       FROM StanjeULP_Kn_Grupacije('2017-09-30', 0)
       WHERE SaldoKolPro <> 0
       AND Neaktivno = 0
      GROUP BY Grupacija
	  ) x1
       ORDER BY Grupacija




	   select *
	   from skladista
	   where vrsta like '%gotovih%'
	   order by grupacija