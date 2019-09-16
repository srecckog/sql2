
SELECT id_skl,sum(saldokolicina) kolicina,sum(saldotezina) tezina
from (
--SELECT  id_skl, case when jm='mm' then  saldokolicina/1000 else saldokolicina end saldokolicina,saldotezina
SELECT  *
FROM feroapp.dbo.StanjeULR('2017-11-20') 
WHERE VrstaUR <> 'Povrat' AND (CASE WHEN VrstaOtpisa = 'Tezinski' THEN SaldoTezina ELSE SaldoKolicina END) <> 0
and id_skl in ( 334,	371,	350,	327,	358,	300,308,	390,361,	394,	392,	252,	153,	155,	118,	39)
) x1
group by id_skl



SELECT  Iznosulr
FROM feroapp.dbo.StanjeULR('2017-11-20') 
WHERE VrstaUR <> 'Povrat' AND (CASE WHEN VrstaOtpisa = 'Tezinski' THEN SaldoTezina ELSE SaldoKolicina END) <> 0
and id_skl in ( 334,	371,	350,	327,	358,	300,308,	390,361,	394,	392,	252,	153,	155,	118,	39)
