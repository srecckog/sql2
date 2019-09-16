USE [rfind]
GO
/****** Object:  Trigger [dbo].[gHR_PrsnInsUD]    Script Date: 19.10.2017. 11:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[gHR_PrsnInsRFID]
ON [dbo].[tHR_Prsn]
FOR INSERT
AS
BEGIN
	IF (@@ROWCOUNT = 0)
		RETURN;

	SET NOCOUNT ON;

	IF ([dbo].[fPA_ContextInfo_IsSet](3) = 0)
		RETURN;

	DECLARE @User_Id int;
	SET @User_Id = (SELECT TOP(1) [anUserIns] FROM [inserted]);
	IF (@User_Id > 0)
		RETURN;

	--SET @User_Id = [dbo].[fPA_UserGetCurrentUserId]();
	declare @k1 bigint
	declare @k2 bigint	
	declare @cid varchar(15)
	declare @dat1 varchar(10)
	declare @dat2 varchar(10)
	declare @custid varchar(3) ,@rfid varchar(15),@rfidhex varchar(15),@rfid2 varchar(15),@dat10 varchar(10)
	declare @ime varchar(50) , @prezime varchar(50) , @idradnika varchar(16);

	-- povezi se sa fx1server.rfind
    Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.5",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";

	set @rfid = (select SUBSTRING(acnoten,1,12) from [inserted]);
	set @idradnika = (select acregno from [inserted]);
	set @ime = (select acname from [inserted]);
	set @prezime = (select acsurname from [inserted]);

set @k1 =  CONVERT(bigint, substring(CONVERT(VARBINARY(8), cast(@rfid as bigint)),1,4) ) 
set @k2 =  CONVERT(bigint, substring(CONVERT(VARBINARY(8), cast(@rfid as bigint)),5,15) ) 
set @cid= cast(@k1 as varchar(3))+ '-'+cast(@k2 as varchar(7))
set @dat10 = getdate()
set @dat1= cast(year(@dat10) as varchar(4))+'-'+cast(month(@dat10) as varchar(2))+'-'+cast(day(@dat10) as varchar(2))
set @dat10 = dateadd(year,15,getdate())
set @dat2= cast(year(@dat10) as varchar(4))+'-'+cast(month(@dat10) as varchar(2))+'-'+cast(day(@dat10) as varchar(2))

EXEC [192.168.0.5].rfind.dbo.fx_import @idradnika,@ime,@prezime,@cid,@dat1,@dat2,0

BEGIN TRY
	Insert into [192.168.0.5].[rfind].dbo.radnici_ (id, prezime,ime,datumzaposlenja,datumprestanka,ulica,grad,telefon1,telefon2,custid,rfid,rfidhex,lokacija,mt,radnomjesto,rfid2,poduzece,sifrarm,rv,neradi,fixnaisplata) 
	Select                                 Distinct i.acregno,i.acsurname ,i.acname,i.addateenter,i.addateexit,acstreet,accity,acphone,acphone,acphone,@custid,@rfid,@rfidhex,p.acdept,p.costdrv,p.acjob,@rfid2,'Fx','',0,0,1
    from Inserted i
	left join thr_prsnjob p on i.acworker=p.acworker
END TRY

	BEGIN CATCH
		EXEC [dbo].[pPA_ContextInfo_Set] 3,0;
		EXEC [dbo].[pPA_Exception_ReRaise]
			NULL
			,	'gHR_PrsnInsRFID'
			,	33
			,	'UPDATE'
			,	NULL
		;
	END CATCH
END