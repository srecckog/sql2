-- 8752 Fero Preis
-- 221453 schaeffler Romania
-- 121274 Schaeffler technologie,
--		  Vrsta narudzbi : prsteni,valjci
-- 121301 Sona BLW 
-- 274 schaeffler Gmbh
-- 221454 Fag India
-- 45150 SIGMA PRO
-- 121273 ina Kysuce - prstenovi

declare @DAT1 DATE
declare @idpar varchar(10)
set @DAT1 = '2017-07-03'
set @idpar='121274'

use feroapp
select SUM(KOLICINAOK) Proizvedeno, 
( select datepart(week,@dat1)-1 ) as KW,
( 
select count(*) 
from 
(	select DISTINCT(LINIJA)
		from evidnormi(@dat1,@dat1,0)
		where id_par=@idpar
) x1
) as Broj_linija,
(select count(*)
from evidnormi(@dat1,@dat1,0)
where id_par=@idpar
and TekstCheck01=1) as Broj_štelanja,
feroapp.dbo.lista_linija(@dat1,@dat1,@idpar) Popis_linija
from evidnormi(@dat1,@dat1,0)
where id_par=@idpar


USE FEROAPP
SELECT *
from EvidNormi('2017-07-04','2017-07-04',0)
where KUPAC like '%gmbh%'


and id_par='121274'








use feroapp
select DISTINCT(LINIJA)
from evidnormi('2017-06-19','2017-06-19',0)
where kupac like '%FERRO%'

use feroapp
select datepart(week,'2017-06-19')-1
from evidnormi('2017-06-19','2017-06-19',0)
where kupac like '%FERRO%'


-- broj štelanja
use feroapp
select *
from evidnormi('2017-03-27','2017-03-27',0)
where kupac like '%FERRO%'
and TekstCheck01=1
order by smjena


use feroapp
select *
from evidnormi('2017-06-19','2017-06-19',0)
where kupac like '%FERRO%'


select *
from partneri
where nazivPAR like '%FERRO%'


select feroapp.dbo.lista_linija('2017-06-19','2017-06-19','8752')

use feroapp
select *
from skladiste

select *
from evidnormi('2017-01-01','2017-07-31',0)
where kupac like '%techno%'