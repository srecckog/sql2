/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_Radnika]
      ,[ID_Fink]
      ,[ID_Firme]
      ,[Ime]
      ,[SifraRM]
      ,[Hala]
      ,[RadNaStroju]
      ,[Steler]
      ,[Kontrola]
      ,[Bravar]
      ,[Pilar]
      ,[NeRadi]
  FROM [FeroApp].[dbo].[Radnici]
  order by ime


  insert into feroapp.dbo.radnici(id_fink,id_firme,ime,sifrarm,hala,radnastroju)
  select id,case when poduzece='Feroimpex' then 1 else 3 end firma,prezime+' '+ime as ime1,case when sifrarm='proizvodnja' then 'Tok' else 'Proizvodnja' end sifrarm,case when lokacija=603 then 3 when lokacija=500 then 1 when lokacija= 521 then 3  end hala,1 radnastroju
  from rfind.dbo.radnici_
  where id>999999999 and id<0
  order by id


  select *
  from rfind.dbo.radnici_
  where id=1047
  