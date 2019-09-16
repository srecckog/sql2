USE feroapp
    EXEC sp_send_dbmail
      @profile_name = ‘MailProfile1’,
      @recipients = ‘srecckog@gmail.com’,
      @subject = ‘T-SQL Query Result’,
      @body = ‘The result from SELECT is appended below.’,
      @execute_query_database = ‘feroapp’,
      @query = ‘SELECT Partneri.NazivPar FROM Partneri’