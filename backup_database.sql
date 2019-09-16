USE rfind;  
GO  
BACKUP DATABASE rfind 
TO DISK = 'x:\brisi\rfind1810.bak'  
   WITH FORMAT,  
      MEDIANAME = 'Z_SQLServerBackups',  
      NAME = 'Full Backup of RFIND';  
GO  