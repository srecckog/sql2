USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[Satnice]    Script Date: 08.05.2017. 11:08:21 ******/
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
      ,[Dan01]
      ,[Dan02]
      ,[Dan03]
      ,[Dan04]
      ,[Dan05]
      ,[Dan06]
      ,[Dan07]
      ,[Dan08]
      ,[Dan09]
      ,[Dan10]
      ,[Dan11]
      ,[Dan12]
      ,[Dan13]
      ,[Dan14]
      ,[Dan15]
      ,[Dan16]
      ,[Dan17]
      ,[Dan18]
      ,[Dan19]
      ,[Dan20]
      ,[Dan21]
      ,[Dan22]
      ,[Dan23]
      ,[Dan24]
      ,[Dan25]
      ,[Dan26]
      ,[Dan27]
      ,[Dan28]
      ,[Dan29]
      ,[Dan30]
      ,[Dan31]
      ,[Stimulacija1]
      ,[Stimulacija2]
      ,[Stimulacija3]
      ,[Stimulacija4]
      ,[Stimulacija5]
      ,[RFID]
      ,[PsrUserList]
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
