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
CREATE PROCEDURE ERN_zbroji 
	-- Add the parameters for the stored procedure here
	@FXid  varchar 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	  SELECT lastname,dan,fxid, Datediff(minute,dosao,otisao)  minuta
  from (
  select max(x1.dt) otisao,min(x1.dt) dosao,convert(varchar,datepart(day,x1.dt))+'.'+convert(varchar,datepart(month,x1.dt) ) +'.'+convert(varchar,datepart(year,x1.dt) )dan ,x1.lastname,x1.extid1 FxId
  from (
  select e.no RFID_Hex,e.no2,dt,e.[User],e.Device_ID,r.name,e.EventType,LastName,u.FirstName,t.CodeName,u.ExtId extid1,b.extid extid2,e.No2 serial_number
  from event e
  left join badge b on e.No= b.BadgeNo
  left join [dbo].[User] u on u.extid=b.extid
  left join eventtype t on e.EventType=t.Code
  left join reader r on e.device_id=r.id
  WHERE E.[USER] IS NOT NULL
  and u.extid=@fxid
 ) x1
 group by convert(varchar,datepart(day,x1.dt))+'.'+convert(varchar,datepart(month,x1.dt) ) +'.'+convert(varchar,datepart(year,x1.dt) ) ,x1.lastname,x1.extid1
 ) x2
  

END
GO
