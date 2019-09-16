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
CREATE PROCEDURE sp_Kompetencije_ 
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- nedolasci nedjeljom
	-- update kompetecnije1105, nn
-----------------------------------------
-- update Kompetencije set [NedolasciNedjeljom]=0
--- 12 mjeseci
update Kompetencije set [NedolasciNedjeljom12]=0

   UPDATE   
    kompetencije

SET	
   [NedolasciNedjeljom12] =j.broj
   
FROM
    (

 select count(*) broj,idradnika
  from pregledvremena pv
  where datepart(dw, datum)=7
  and year(dosao)=1900
  and datediff( day , pv.datum, getdate()  )/30 <=12
  
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  group  by idradnika
  
  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 


--- 6 mjeseci
update Kompetencije set [NedolasciNedjeljom6]=0

   UPDATE   
    kompetencije

SET	
   [NedolasciNedjeljom6] =j.broj
   
FROM
    (

 select count(*) broj,idradnika
  from pregledvremena pv
  where datepart(dw, datum)=7
  and year(dosao)=1900
  and datediff( day , pv.datum, getdate()  )/30 <=6
  
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  group  by idradnika
  
  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 

--- 3 mjeseci
update Kompetencije set [NedolasciNedjeljom6]=0

   UPDATE   
    kompetencije

SET	
   [NedolasciNedjeljom6] =j.broj
   
FROM
    (

 select count(*) broj,idradnika
  from pregledvremena pv
  where datepart(dw, datum)=7
  and year(dosao)=1900
  and datediff( day , pv.datum, getdate()  )/30 <=3
  
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  group  by idradnika
  
  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 


--- 1 mjeseci
update Kompetencije set [NedolasciNedjeljom1]=0

   UPDATE   
    kompetencije

SET	
   [NedolasciNedjeljom1] =j.broj
   
FROM
    (

 select count(*) broj,idradnika
  from pregledvremena pv
  where datepart(dw, datum)=7
  and year(dosao)=1900
  and datediff( day , pv.datum, getdate()  )/30 <=1
  
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  group  by idradnika
  
  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 

	------------------------------------
	- nedolasci subotom
	-------------------------------------
update Kompetencije set [Neopravdano_puta12]=0,[NeopravdaniDani12]=0,[NedolasciNedjeljom12]=0,[NedolasciSubotom12]=0
  
  UPDATE   kompetencije

SET	
   [NeopravdaniDani12]   = j.brojdana,
   [Neopravdano_puta12]  = j.puta,
   [NedolasciSubotom12]  = j.sn

FROM
    (

	SELECT [mt]
      ,[mjestotroska]
      ,[id]
      ,[ime]
      ,[mjesec]
      ,[godina]
      ,[puta]
      ,[brojdana]
      ,[sn]
      ,[nn]
      ,[firma]
      ,[razlog]
  FROM [RFIND].[dbo].[odsustva2017]
  where (datediff( day , pv.datum, getdate()  )/30 )<=12
  and razlog='N'

  ) j

INNER JOIn kompetencije k
ON 
    j.id = k.id 




	
END
GO

