USE [RFIND]
GO

INSERT INTO [dbo].[Norme_log]
           ([datum]
           ,[id_pro]
           ,[staranorma]
           ,[novanorma]
           ,[hala]
           ,[linija])
     VALUES
           (<datum, date,>
           ,<id_pro, nchar(10),>
           ,<staranorma, int,>
           ,<novanorma, int,>
           ,<hala, nchar(10),>
           ,<linija, nchar(15),>)
GO


select * into norme_log