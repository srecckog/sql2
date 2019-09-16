USE FeroApp; 

DECLARE @TmpOrderNo DECIMAL(10,0);

SET @TmpOrderNo = 5183637;

WITH MyTmpTable AS
(SELECT VrstaNar, Bazni_RN, OrderNo, KolicinaNar, BaznaObrada, ZavrsnaObrada, DatumIsporuke, 
       (CASE ZavrsnaObrada WHEN 'Obrada #5' THEN SpremnoO5_Pro WHEN 'Brusenje' THEN SpremnoBR_Pro WHEN 'Tvrdo tokarenje' THEN SpremnoTT_Pro WHEN 'Kaljenje' THEN SpremnoK_Pro ELSE SpremnoT_Pro END) AS Spremno 
       FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno') 
       WHERE OrderNo = @TmpOrderNo)

SELECT * FROM MyTmpTable WHERE Spremno <> 0 



(SELECT VrstaNar, Bazni_RN, OrderNo, KolicinaNar, BaznaObrada, ZavrsnaObrada, DatumIsporuke, 
       (CASE ZavrsnaObrada WHEN 'Obrada #5' THEN SpremnoO5_Pro WHEN 'Brusenje' THEN SpremnoBR_Pro WHEN 'Tvrdo tokarenje' THEN SpremnoTT_Pro WHEN 'Kaljenje' THEN SpremnoK_Pro ELSE SpremnoT_Pro END) AS Spremno 
       FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno') 
       WHERE OrderNo =5183637)