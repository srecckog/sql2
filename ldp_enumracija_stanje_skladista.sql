SELECT 
(CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Kupac' END) AS Vlasnistvo, 
VrstaOtpisa, SUM(CASE WHEN VrstaOtpisa = 'Komadno' THEN SaldoKolicina ELSE SaldoTezina END) AS Saldo,VrstaMat 
FROM StanjeULR('2016-05-19') 
WHERE (CASE WHEN VrstaOtpisa = 'Komadno' THEN SaldoKolicina ELSE SaldoTezina END) <> 0 AND VrstaUR <> 'Povrat' AND Neaktivno = 0 
and vrstamat='Repromaterijal'
GROUP BY VlasnistvoFX, VrstaOtpisa , VrstaMat
order by vrstamat



--------------------- stanjeulr
declare @DanStanja as date
SET @DanStanja= '2016-05-19'
	  SELECT *, 
	( SELECT dbo.CalcStanjeULR(ID_ULR,@DanStanja) )    AS SaldoKolicina, 
	( SELECT dbo.CalcStanjeULR_Kg(ID_ULR,@DanStanja) ) AS SaldoTezina,
	( SELECT dbo.CalcStanjePakiranja(ID_ULR,@DanStanja,'ULR') ) AS SaldoPakiranja 
	FROM UlazRobeDetaljnoView 
	WHERE DatumDokumenta <= @DanStanja AND Odobreno = 1

	use feroapp
	declare @DanStanja as date
    SET @DanStanja= '2016-05-19'
	select *
	( dbo.calcstanjeulr(ID_ULR,@DanStanja) as tez ) 
	FROM UlazRobeDetaljnoView 
	WHERE DatumDokumenta <= @DanStanja AND Odobreno = 1




	declare @DanStanja as date
	SET @DanStanja= '2016-05-19'
	select * 
	FROM UlazRobeDetaljnoView WHERE DatumDokumenta <= @DanStanja AND Odobreno = 1
	and vrstamat='Odljevak'
	and vlasnistvofx=0
	order by VrstaMat
	

	select *
	from skladista

	WHERE DatumDokumenta <= @DanStanja AND Odobreno = 1

