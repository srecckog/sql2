/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Idradnika]
      ,[idvjestine]
      ,[Firma]
  FROM [RFIND].[dbo].[RadniciVjestine]


  update radnicivjestine set firma=3
  
  select j.*,r.*
  from
  (
  select *
  from radnici_
  where poduzece='Feroimpex'
  ) j
  inner join radnicivjestine r on r.idradnika=j.id




  set firma=3 where idradnika in ( 75,