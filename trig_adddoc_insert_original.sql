USE [PantheonFxAt]
GO
/****** Object:  Trigger [dbo].[gHR_PrsnAddDocInsUD]    Script Date: 6.11.2017. 11:07:00 ******/
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