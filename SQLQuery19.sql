USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[Realizacija2]    Script Date: 21.8.2017. 10:06:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Realizacija2]
	-- Add the parameters for the stored procedure here
	@dat1 varchar(12),
	@dat2 varchar(12),
	@id int,
	@smjena int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
 
------------------ evidencija normi - gedrehte ringe 3
-- Realizacija
-- BDF
if @id=1

begin
SELECT * FROM feroapp.dbo.EvidencijaProizvedenoFakturirano_Zbirno_SG(@dat1, @dat2, @smjena)
end

else if @id=10 -- kupac, broj_štelanja novo

--select kupac,vrstanarudzbe,count(*) broj_stelanja   staro
--from feroapp.dbo.evidnormi( @dat1, @dat2 , 0 )
--where tekstcheck01=1
-- group by kupac,VrstaNarudzbe
begin
declare @dat11 varchar(20)
declare @dat12 varchar(20)

set @dat11 = @dat1 + ' 6:00:00'
set @dat12 = @dat2 + ' 6:00:00'

select v.kupac,v.vrstanarudzbe,count(*) broj_stelanja
from (
select e.vrstanarudzbe ,e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.smjena,e.linija,e.nazivpro,e.norma,e.kolicinaok,e.zavrsnaobrada,e.kupac,e.radnik,z.trajanje trajanjezastoja,z.aktivnost
from feroapp.dbo.evidnormi(@dat1,@dat1,0) e
left join 
(

SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   left join feroapp.dbo.narudzbesta n on n.brojrn1=plia.brojrn
	   left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
	   where pocetak>=@dat11 and  ( kraj<=@dat12 or kraj is null)
	   
) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
where z.aktivnost like '%Štelanje%' and e.Smjena=3
)v
group by kupac,vrstanarudzbe
end

else if @id=2 -- kupac, broj_linija

begin
select kupac,vrstanarudzbe,count(*) broj_linija
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1, @dat2 , 0 )
where  gotovo=1 and obrada3=0 and KolicinaOK >= 0 and smjena=@smjena
) x1
group by kupac,vrstanarudzbe
order by kupac
end

else if @id=22 -- kupac, korekcija broja_linija

begin 

select '_Ukupno' kupac,sum(trajanje) ukupnotr
from (
select case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
where smjena=@smjena
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
where smjena=@smjena
) x1

union all

select kupac,sum(trajanje) ukupnotr
from (
select kupac,case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
where smjena=@smjena
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
where smjena=@smjena
) x1
group by kupac
order by kupac
end


else if @id=3  -- komada,broj_škart obrade i materijala

begin 
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where kupac like '%Austria%' and smjena=@smjena
group by kupac,VrstaNarudzbe,turm
union all
-- SONA
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SONA%'  and smjena=@smjena
group by kupac,VrstaNarudzbe,turm
union all
-- Brasil
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Brasil%'  and smjena=@smjena
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Romania
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Romania%'  and smjena=@smjena
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Schaeffler Technologies, prsteni
select kupac+' Prsteni',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%'  and VrstaNarudzbe like '%prsteni%' and smjena=@smjena
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Schaeffler Technologies, valjci
select kupac+' Valjci',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' and VrstaNarudzbe like '%valjci%' and smjena=@smjena
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- ostali
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where gotovo=1 and  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%'AND KUPAC NOT LIKE '%Brasil%'  and smjena=@smjena
group by kupac,VrstaNarudzbe,turm
END




else if @id=4


begin 

select sum(x1.tezinaprokom*kolicina) tezina,pec
from (
select x3.pec,x3.kratkinaziv,x3.radnik,x3.TezinaProKom,x3.Smjena,sum(x3.Kolicina-x3.KrivuljaRezanje) as kolicina 
from (select x1.Datum,x1.ID_Radnika,x1.NapomenaCodere,x1.NapomenaSolo,x1.Radnik,x1.Smjena,x2.* from ( 
SELECT [ID_KKSZ],[Datum] ,[Smjena] ,[ID_Radnika] ,[Radnik] ,[NapomenaCodere] ,[NapomenaSolo]  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag] 
WHERE DATUM=@dat1 ) x1 
left join [FeroApp].[dbo].[KalionicaKnjigaSmjenesta] as x2  on x1.id_kksz=x2.ID_KKSZ ) x3 
where x3.smjena=@smjena
group by x3.pec,x3.kratkinaziv,x3.smjena,x3.TezinaProKom,x3.radnik 
) x1
group by pec
end

else if @id=41  -- kaliona  broj sarzi, po peci i smjenama

begin 


select pec,count(brojsarze) brojsarzi
from(
select distinct x2.pec,brojsarze from ( 
SELECT [ID_KKSZ],[Datum] ,[Smjena] ,[ID_Radnika] ,[Radnik] ,[NapomenaCodere] ,[NapomenaSolo]  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag] 
WHERE DATUM=@dat1 and Smjena=@smjena ) x1 
left join [FeroApp].[dbo].[KalionicaKnjigaSmjenesta] as x2  on x1.id_kksz=x2.ID_KKSZ 
) x1
group by pec
end

end
