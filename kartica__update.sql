USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[Update_rfid_kartice]    Script Date: 16.10.2017. 11:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Update_rfid_kartice] 
	-- Add the parameters for the stored procedure here
	@idradnika int,
	@rfid bigint,
	@ime varchar(25),
	@prezime varchar(25)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- Add the T-SQL statements to compute the return value here
declare @k1 bigint
declare @k2 bigint
declare @cid varchar(15)
declare @dat1 varchar(10)
declare @dat2 varchar(10)

--declare @rfid bigint
--set @rfid = 536874517707
set @k1 =  CONVERT(bigint, substring(CONVERT(VARBINARY(8), cast(@rfid as bigint)),1,4) ) 
set @k2 =  CONVERT(bigint, substring(CONVERT(VARBINARY(8), cast(@rfid as bigint)),5,15) ) 
set @cid= cast(@k1 as varchar(3))+ '-'+cast(@k2 as varchar(7))
set @dat1= FORMAT(getdate(),'YYYY-MM-DD') 
set @dat2= FORMAT(dateadd(year,15,getdate()),'YYYY-MM-DD') 

EXEC rfind.dbo.fx_import @idradnika,@ime,@prezime,@cid,@dat1,@dat2,0

END
