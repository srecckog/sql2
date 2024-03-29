USE [RFIND]
GO

DECLARE	@return_value int
DECLARE	@id int
DECLARE	@no varchar(50)
DECLARE	@user1 varchar(50)
DECLARE	@lastn varchar(50)
DECLARE	@name varchar(50)
declare @custid varchar(3)
DECLARE	@serijskibroj varchar(16)


declare @csn1 varchar(50)
declare @customid varchar(50)

DECLARE db_cursor CURSOR FOR  
SELECT id,rfid2,ime,prezime
FROM radnici_
where id>1326 and id<8000
 

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @id,@serijskibroj,@name,@lastn 

WHILE @@FETCH_STATUS = 0   
BEGIN   
       	   
		   
EXEC	@return_value = [dbo].[FX_Import]
		@EXT_ID = @id,
		@FNAME = @name,
		@LNAME = @lastn,
		@CSN = @serijskibroj,
		@START_TIME = N'2017-01-25',
		@END_TIME = N'2030-11-30',
		@STATUS = 0

		FETCH NEXT FROM db_cursor INTO @id,@serijskibroj,@name,@lastn 
		print @serijskibroj
END   

CLOSE db_cursor   
deallocate db_cursor















EXEC	@return_value = [dbo].[FX_Import]
		@EXT_ID = N'1173',
		@FNAME = N'Srećkoo',
		@LNAME = N'Gašparić',
		@CSN = N'125-3605707',
		@START_TIME = N'2016-011-01',
		@END_TIME = N'2017-11-30',
		@STATUS = 0

SELECT	'Return Value' = @return_value

GO



DECLARE @name VARCHAR(50) -- database name  
DECLARE @path VARCHAR(256) -- path for backup files  
DECLARE @fileName VARCHAR(256) -- filename for backup  
DECLARE @fileDate VARCHAR(20) -- used for file name 

SET @path = 'C:\Backup\'  

SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) 

DECLARE db_cursor CURSOR FOR  
SELECT name 
FROM MASTER.dbo.sysdatabases 
WHERE name NOT IN ('master','model','msdb','tempdb')  

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   
BEGIN   
       SET @fileName = @path + @name + '_' + @fileDate + '.BAK'  
       BACKUP DATABASE @name TO DISK = @fileName  

       FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor
