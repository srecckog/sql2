USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[TV_dpr]    Script Date: 1.2.2019. 8:38:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[TV_dpr] 
	-- Add the parameters for the stored procedure here
	@hala int,
	@tip int
	
AS
BEGIN

-- tjedna realizacija
if @tip=1
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 select datum,sum(kolicinaok) kolicina,sum(norma) norma
  from feroapp.dbo.evidnormi( DATEADD(day,-7,getdate()),getdate(),0)
  where hala=@hala and kolicinaok>0
  group by datum
  order by datum
end

-- mjesečna realizacija
if @tip=2
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 select datum,sum(kolicinaok) kolicina,sum(norma) norma
  from feroapp.dbo.evidnormi( DATEADD(day,-30,getdate()),getdate(),0)
  where hala=@hala and kolicinaok>0
  group by datum
  order by datum
end

-- dnevna realizacija
if @tip=3
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 select smjena ,sum(kolicinaok) kolicina,sum(norma) norma
  from feroapp.dbo.evidnormi( DATEADD(day,-1,getdate()),DATEADD(day,-1,getdate()),0)
  where hala=@hala and kolicinaok>0
  group by smjena
  order by smjena
end

-- info pult 04.12.2018.
if @tip=4

declare @sat int
declare @dodatak int

set @sat = DATEPART(HOUR, GETDATE())
set @dodatak = 0

if @sat<14
       set @dodatak=-1

begin
  select '1' id,'D' tip,@dodatak oznaka, sum(kolicinaok) kolicinaok
  from feroapp.dbo.evidnormi(getdate()+@dodatak,getdate()+@dodatak,0)  
  
  --where hala=@hala
  union all
  select '2' id,'T' tip,@dodatak oznaka,sum(kolicinaok) kolicinaok
  from feroapp.dbo.evidnormi(getdate()-30,getdate(),0)
  where datepart(week,datum)=datepart(week,getdate()+@dodatak)  
  
  -- and hala=@hala
  union 
  select '3' id,'M' tip,@dodatak oznaka,sum(kolicinaok) kolicinaok
  from feroapp.dbo.evidnormi(getdate()-60,getdate(),0)
  where month(datum)=month(getdate()+@dodatak) and year(datum)=year(getdate()+@dodatak) 
  
  -- and hala=@hala  
  order by id
end



END
