USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[Realizacija]    Script Date: 26.7.2017. 13:55:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Realizacija]
	-- Add the parameters for the stored procedure here
	@dat1 varchar(12),
	@dat2 varchar(12),
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
 
------------------ evidencija normi - gedrehte ringe 3
-- Realizacija
-- BDF

if @id=1   -- komada,broj_štelanja

begin 
select kupac,sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  gotovo=1 and kupac like '%Austria%' and obrada3=0 and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where gotovo=1 and kupac like '%Austria%' and obrada3=0
group by kupac,VrstaNarudzbe
union all
-- SONA
select kupac,sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%SONA%' AND OBRADAA=1 and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SONA%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Romania
select kupac,sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Romania%' AND OBRADAA=1 and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Romania%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, prsteni
select kupac+' Prsteni',sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%prsteni%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%prsteni%'
group by kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, valjci
select kupac+' Valjci',sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%'
group by kupac,VrstaNarudzbe
UNION ALL
-- ostali
select kupac,sum(kolicinaok) kolicinaok, (select count(*)  from ( select distinct BrojRN  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  gotovo=1 and  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where gotovo=1 and  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%'
group by kupac,VrstaNarudzbe
END

else if @id=2 -- kupac, broj_linija

begin
-- BDF
select kupac,VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  gotovo=1 and kupac like '%Austria%' and obrada3=0 and KolicinaOK > 0
) x1
group by kupac,VrstaNarudzbe

union all
-- SONA
select kupac,VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SONA%' AND OBRADAA=1) x1
group by kupac,VrstaNarudzbe

UNION ALL
-- Romania
select kupac,VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where kupac LIKE '%Romania%' AND OBRADAA=1 ) x1
group by kupac,VrstaNarudzbe
union all
-- Schaeffler Technologies, prsteni
select kupac+'Prsteni',VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%prsteni%' ) x1
group by kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, valjci
select kupac+'Valjci',VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%') x1
group by kupac,VrstaNarudzbe
UNION ALL
-- ostali
select kupac,VrstaNarudzbe,count(*) broj_linija from (
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where gotovo=1 and  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%') x1
group by kupac,VrstaNarudzbe
end

else if @id=3  -- komada,broj_škart obrade i materijala

begin 
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where kupac like '%Austria%' 
group by kupac,VrstaNarudzbe,turm
union all
-- SONA
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SONA%' 
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Romania
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Romania%' 
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Schaeffler Technologies, prsteni
select kupac+' Prsteni',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%'  and VrstaNarudzbe like '%prsteni%'
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Schaeffler Technologies, valjci
select kupac+' Valjci',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%'
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- ostali
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where gotovo=1 and  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%'
group by kupac,VrstaNarudzbe,turm
END

else if @id=4  -- kaliona  komada,pec   

begin 

select sum(x1.tezinaprokom*kolicina) tezina,pec
from (
select x3.pec,x3.kratkinaziv,x3.radnik,x3.TezinaProKom,x3.Smjena,sum(x3.Kolicina-x3.KrivuljaRezanje) as kolicina 
from (select x1.Datum,x1.ID_Radnika,x1.NapomenaCodere,x1.NapomenaSolo,x1.Radnik,x1.Smjena,x2.* from ( 
SELECT [ID_KKSZ],[Datum] ,[Smjena] ,[ID_Radnika] ,[Radnik] ,[NapomenaCodere] ,[NapomenaSolo]  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag] 
WHERE DATUM=@dat1 ) x1 
left join [FeroApp].[dbo].[KalionicaKnjigaSmjenesta] as x2  on x1.id_kksz=x2.ID_KKSZ ) x3 
group by x3.pec,x3.kratkinaziv,x3.smjena,x3.TezinaProKom,x3.radnik 
) x1
group by pec

end

else if @id=5  -- realizacija ukupno
begin 

  Exec sp_addlinkedsrvlogin @rmtsrvname="FXSQL2",@useself=false, @rmtuser="sa", @rmtpassword="banana22"
  select LINIJA,SUM(KOLICINA) K1,SUM(CIJENA) V1
  from [fxsql2].fxapp.dbo.ldp_aktivnost
  where datum=@dat1
  and id_partner=0 and linija in ( 'PLANIRANO','REALIZIRANO')
  GROUP BY LINIJA
  ORDER BY LINIJA

  EXEC sp_dropserver 'FXSQL2','droplogins'
end


else if @id=6 -- realizacija kaliona

begin 
  Exec sp_addlinkedsrvlogin @rmtsrvname="FXSQL2",@useself=false, @rmtuser="sa", @rmtpassword="banana22"
  select sum(iznos) VTO
  from [fxsql2].fxapp.dbo.ldp_aktivnost
  where datum=@dat1
  and hala=100  
  EXEC sp_dropserver 'FXSQL2','droplogins'
end


end
