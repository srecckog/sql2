-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Izostanci
	-- Add the parameters for the stored procedure here
	@datum1 date
	
AS
BEGIN

---- pregled djelatnika  koji rade vise od 12 sati
--select pv.datum,r.id,r.prezime,r.ime,pv.radnomjesto,pv.hala,pv.smjena,round(ukupno_minuta/60,1) sati, ukupno_minuta,pv.rbroj,pv.dosao,pv.otisao
--from pregledvremena pv
--left join radnici_ r on r.id=pv.idradnika
--where datum>='2017-06-06'
--and ukupno_minuta>690
--order by datum
---------------
---------------

--declare @datum11 date ='2017-06-06';

-- select *
-- from evidencijaodsustva
-- where datum=@datum1
-- where DATEDIFF(day,datum,getdate())=1
-----------------------------------------------------------
----------------------------------------------------------
---------------------------------------------------------- izostaNCI
--create table pv_izostanci
-- (
-- Datum Date ,
-- ID int,
-- Ime varchar(40),
-- Prezime varchar(40),
-- MT_naziv varchar(40),
-- MT varchar(15),
-- RadnoMjesto varchar(50),
-- Hala varchar(10),
-- Smjena varchar(2),
-- Napomena varchar(60),
-- "Zaplanirani (  nije dosao)" varchar(40),
-- "Dosao, nije zaplanirani" varchar(40),
-- "Kasni (minuta)" int,
-- "Nedostaje (minuta)" int,
-- "Prerano otišao" int
-- )

insert into pv_izostanci ( 
 
 Datum ,
 ID ,
 Ime,
 Prezime,
 MT_naziv,
 MT,
 RadnoMjesto,
 Hala,
 Smjena,
 Napomena,
 Napomena2,
 "Dosao, nije zaplanirani" ,
 "Kasni (minuta)",
 "Nedostaje (minuta)",
 "Prerano otišao"
 
 )

select 

 x1.Datum ,
 x1.ID ,
 x1.Ime,
 x1.Prezime,
 x1.MT_naziv,
 x1.MT,
 x1.RadnoMjesto,
 x1.Hala,
 x1.Smjena,
 x1.Napomena,
 x1.napomena2,
 x1.DNZP ,
 x1.Kasni,
 x1.Nedostaje,
 x1.Preranootišao

from (

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,'' napomena2,''as 'DNZP','' as 'Kasni','' as 'Nedostaje','' as 'Preranootišao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where (pv.radnomjesto ='BO'  or pv.radnomjesto='GO' or pv.radnomjesto='G.O.' )
AND datum=@datum1
--and datum='2017-06-06'

UNION ALL

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,'' napomena2,case when (pv.otisao=pv.dosao) then 'Nije dosao' end Napomena2,'' ZND,''as 'DNZP','' as 'Kasni','' as nedostaje,'' as 'Preranootišao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where  year(pv.otisao)=1900
AND pv.radnomjesto NOT IN ('BO' ,'GO' ,'G.O.','4. SMJENA')
AND datum=@datum1
and r.id is not null

union all

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena, '' as Napomena2 ,''as 'DNZP', pv.kasni ,'' as nedostaje,pv.PreranoOtisao
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where  ( pv.kasni>0 or pv.PreranoOtisao>0)
AND pv.radnomjesto NOT IN ('BO' ,'GO' ,'G.O.','4. SMJENA')
AND datum=@datum1
and r.id is not null and r.id !=695

union all

select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,pv.Napomena,'' as napomena2,'Dosao, a vodi se na bolovanju' as 'DNZP','' as 'Kasni','' as nedostaje,'' as 'Preranootišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where pv.RadnoMjesto in ( 'BO','GO')
and pv.IDRadnika in
(
select u.ExtId
from [User] u
left join event e on u.OID=e.[User]
left join reader r on r.id=e.Device_ID
where DATEDIFF(day,e.dt,@datum1)=0 AND E.EVENTTYPE='SP39'
and r.Door not in ( 7,8,9,10)
)
and datum=@datum1

union all

--select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena, ( rtrim(pv.Napomena)+' nije odradio 8 sati, nedostaje  '+cast( (480-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u '+cast(pv.dosao as nvarchar) +' otišao u '+convert(pv.otisao as nvarchar) ) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)'
-- nedostaje1 , èistaèice
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 8 sati, nedostaje  '+cast( (420-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' otišao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'DNZP',pv.kasni as 'Kasni', (420-pv.Ukupno_minuta+pv.kasni) as Nedostaje,'' as 'Preranootišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv=8
and pv.Ukupno_minuta<420
and ((420 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and datum=@datum1

union all
-- nedostaje11, ostali 8 sati
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 8 sati, nedostaje  '+cast( (480-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' otišao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'DNZP','' as 'Kasni', (pv.PreranoOtisao + pv.kasni) as Nedostaje,'' as 'Preranotisao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv!=8
and pv.Ukupno_minuta<480
and ((480 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and datum=@datum1

union all

-- nedostaje111, 16 sati

select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 16 sati, nedostaje  '+cast( (960-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' otišao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'DNZP','' as 'Kasni', (960-pv.Ukupno_minuta+pv.kasni) as Nedostaje,'' as 'Preranootišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv!=8
and ( pv.Ukupno_minuta<960 and pv.Ukupno_minuta>800)
and ((960 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and datum=@datum1

) x1


order by r.mt,r.prezime,pv.datum,pv.RadnoMjesto,PV.Smjena
-----------------------------------------------------
-----------------------------------------------------	



END
GO
