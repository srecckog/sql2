----------UPISATI PODATKE----------
use FxSAP
 
DECLARE @Ime nvarchar(100)
DECLARE @RFID varchar(14)
DECLARE @Od date
DECLARE @Do date
SET DATEFORMAT dmy
 
----------UPISATI PODATKE----------
SET @Ime = 'hajtok'
SET @Od='1.3.2016'
SET @Do='31.3.2016'
-----------------------------------
SET @RFID = (SELECT TOP 1 RFID FROM PlanSatiRada WHERE Ime LIKE '%' + @Ime + '%' and RFID is not null)
 
IF @RFID is not null SELECT (SELECT TOP 1 Ime FROM PlanSatiRada WHERE RFID = @RFID) AS Djelatnik, @Od AS Od, @Do AS Do, @RFID AS 'RFID broj (kartica)' 
 
IF @RFID is not null SELECT Datum, Vrijeme, Naziv, RFID FROM RestStavke WHERE RFID = @RFID and Datum between(@Od) and (@Do) AND ID_RJE IN(SELECT ID_RJE FROM RestJela WHERE Grupacija = 'Glavno jelo')
ORDER BY Datum, Vrijeme
 
IF @RFID is not null SELECT @@ROWCOUNT AS [Broj gableca], @@ROWCOUNT * 15 AS Kn
 
IF @RFID is null SELECT 'NIJE PRONAÐEN RFID BROJ' AS Komentar
 
