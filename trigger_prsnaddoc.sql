USE [PantheonFxAt]
GO
/****** Object:  Trigger [dbo].[gHR_PrsnAddDocInsUD]    Script Date: 6.11.2017. 10:13:55 ******/
/** changed/added on 06.11.2017.  - author:sreæko **/
/** subject: run fx_import, it update rfind database **/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[gHR_PrsnAddDocInsUD]
ON [dbo].[tHR_PrsnAddDoc]
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

	SET @User_Id = [dbo].[fPA_UserGetCurrentUserId]();

	EXEC [dbo].[pPA_ContextInfo_Set] 3,1;

	declare @k1 bigint
	declare @k2 bigint	
	declare @cid varchar(15)
	declare @dat1 varchar(10)
	declare @dat2 varchar(10)
	declare @tipdoc int
	declare @custid varchar(3) ,@rfid varchar(15),@rfidhex varchar(15),@rfid2 varchar(15),@dat10 varchar(10)
	declare @ime varchar(50) , @prezime varchar(50) , @idradnika varchar(16);


	BEGIN TRY
		UPDATE [dbo].[tHR_PrsnAddDoc]
		SET
			[adTimeIns] = ISNULL([dbo].[tHR_PrsnAddDoc].[adTimeIns],GETDATE())
		,	[anUserIns] = ISNULL(NULLIF([dbo].[tHR_PrsnAddDoc].[anUserIns],0),@User_Id)
		,	[adTimeChg] = ISNULL([dbo].[tHR_PrsnAddDoc].[adTimeChg],GETDATE())
		,	[anUserChg] = ISNULL(NULLIF([dbo].[tHR_PrsnAddDoc].[anUserChg],0),@User_Id)
		FROM
			[inserted]
		WHERE
			[dbo].[tHR_PrsnAddDoc].acWorker = [inserted].acWorker AND [dbo].[tHR_PrsnAddDoc].anId = [inserted].anId
		;


		EXEC [dbo].[pPA_ContextInfo_Set] 3,0;
	
	set @tipdoc = (select count(*) dalikartica from [inserted] i left join thr_prsnadddoc a on i.acworker=a.acworker and i.anid=a.anid and  i.actype='8');

	if @tipdoc>0 -- ako se unosi kartica
	begin
		set @rfid = (select SUBSTRING(i.acnumber,1,12) from [inserted] i left join tHR_PrsnAddDoc p on p.acworker = i.acWorker where p.acworker=i.acworker and  p.anId = i.anId);
		set @idradnika = (select acregno from thr_prsn p left join inserted i on i.acworker=p.acworker);
		set @ime = (select acname from thr_prsn p left join inserted i on i.acworker=p.acworker)
		set @prezime = (select acsurname from thr_prsn p left join inserted i on i.acworker=p.acworker);

		set @k1 =  CONVERT(bigint, substring(CONVERT(VARBINARY(8), cast(@rfid as bigint)),1,4) ) 
		set @k2 =  CONVERT(bigint, substring(CONVERT(VARBINARY(8), cast(@rfid as bigint)),5,15) ) 
		set @cid= cast(@k1 as varchar(3))+ '-'+cast(@k2 as varchar(7))
		set @dat10 = getdate()
		set @dat1= cast(year(@dat10) as varchar(4))+'-'+cast(month(@dat10) as varchar(2))+'-'+cast(day(@dat10) as varchar(2))
		set @dat10 = dateadd(year,15,getdate())
		set @dat2= cast(year(@dat10) as varchar(4))+'-'+cast(month(@dat10) as varchar(2))+'-'+cast(day(@dat10) as varchar(2))

		-- povezi se sa fx1server.rfind
		Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.5",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";

		-- pokreni fx_import, update rfind baze
		EXEC [192.168.0.5].[rfind].[dbo].fx_import @idradnika,@ime,@prezime,@cid,@dat1,@dat2,0
	end

	END TRY
	


	BEGIN CATCH
		EXEC [dbo].[pPA_ContextInfo_Set] 3,0;
		EXEC [dbo].[pPA_Exception_ReRaise]
			NULL
			,	'gHR_PrsnAddDocInsUD'
			,	33
			,	'UPDATE'
			,	NULL
		;
	END CATCH
END