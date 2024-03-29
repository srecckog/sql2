USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[Satnice]    Script Date: 08.05.2017. 11:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Satnice]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
--	<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	
	SELECT TOP 1000 [PsrID]
      ,[Firma]
      ,[RadnikID]
      ,[Ime]
      ,[SifraRM]
      ,[VrstaRM]
      ,[MT]
      ,[SatnicaKn]
      ,[TjednoRadnihSati]
      ,[DjelomicanRad]
      ,[DanDolaska]
      ,[DanOdlaska]
      ,[Godina]
      ,[Mjesec]
      ,[BrojDanaUmjesecu]
      ,[Stimulacija1]
      ,[Stimulacija2]
      ,[Stimulacija3]
      ,[Stimulacija4]
      ,[Stimulacija5]

      
  FROM [FxSAP].[dbo].[PlanSatiRada]
  where godina>=2016
and radnikid not in 
(
select radnikid
from [FxSAP].[dbo].[PlanSatiRada]
where godina>=2016
and danodlaska is NOT NULL
)
order by ime,godina*100+mjesec DESC


END
