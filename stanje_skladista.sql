USE [FeroApp]
GO
/****** Object:  UserDefinedFunction [dbo].[lista_linija]    Script Date: 11.7.2017. 12:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[lista_linija]
(@dat1 date, @dat2 date,@idpar varchar(10))
RETURNS varchar(120)
AS
BEGIN
    
	DECLARE @CustId int ; declare @LISTA as varchar(120) ;DECLARE @LINIJA1 AS VARCHAR(15)   

	DECLARE CustList CURSOR FOR
	SELECT DISTINCT LINIJA FROM EVIDNORMI(@DAT1,@DAT2,0) where id_par=@idpar

	OPEN CustList
	FETCH NEXT FROM CustList 
	INTO @LINIJA1
	set @lista=''

	WHILE @@FETCH_STATUS = 0
	BEGIN

	    SET @LISTA =  @lista + @LINIJA1 +' ; '
	  
	  FETCH NEXT FROM CustList 
	    INTO @LINIJA1
	END
	CLOSE CustList
	DEALLOCATE CustList

    
	RETURN @lista

END
