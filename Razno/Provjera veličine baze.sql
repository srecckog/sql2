
declare @preveliko int

SET @preveliko=(select case when sum(size*8/1024)>300 then 1 else 0 end sizealert from sys.master_files where type = 0 and name='RFIND' group by name)


IF @preveliko=1 
begin
EXEC msdb.dbo.sp_send_dbmail 
    @profile_name = 'FxSqlServer', 
    @recipients = 'gasparic.s@feroimpex.hr', 
    @body = 'Baza RFINFD je prevelika' ,
    @subject ='Baza RFINFD je prevelika' ,
    @body_format = 'HTML', 
	@query = '', 
    @query_no_truncate = 1, 
    @attach_query_result_as_file = 0;
end



