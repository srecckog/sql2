/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_NarS]
      ,[ID_NarZ]
      ,[PozicijaKupac]
      ,[ID_Pro]
      ,[ID_Mat]
      ,[NazivPro]
      ,[BrojSarze]
      ,[CijenaMatTona]
      ,[KolicinaNar]
      ,[Obrada1]
      ,[CijenaObrada1]
      ,[CijenaObrada1B]
      ,[CijenaObrada1C]
      ,[CijenaObrada1D]
      ,[CijenaObrada1E]
      ,[CijenaObrada1F]
      ,[BrojRN1]
      ,[BrojNar1]
      ,[Obrada2]
      ,[CijenaObrada2]
      ,[BrojRN2]
      ,[BrojNar2]
      ,[Obrada3]
      ,[CijenaObrada3]
      ,[BrojRN3]
      ,[BrojNar3]
      ,[Obrada4]
      ,[CijenaObrada4]
      ,[BrojRN4]
      ,[BrojNar4]
      ,[Obrada5]
      ,[CijenaObrada5]
      ,[BrojRN5]
      ,[BrojNar5]
      ,[DatumIsporuke]
      ,[Z_FiRupe]
      ,[PostotakNaBrutto]
      ,[TezinaSirovcaNetto]
      ,[DodatakNaMaluSerijuNar]
      ,[DodatakNaMaluSerijuKom]
      ,[FakturnaCijena]
      ,[OznakaMatPro]
      ,[LoanPosao]
      ,[BrojRN]
      ,[BazniRN]
      ,[Aktivno]
      ,[Isporuceno]
      ,[BrojRN_Veza]
      ,[Napomena]
      ,[UserName]
      ,[DatumOtvaranjaRN]
      ,[DatumDovrsetkaRN]
      ,[KolicinaMaleSerije]
      ,[ParentRN]
      ,[Nacrt_Index]
      ,[Nacrt_ECV]
      ,[InheritParent]
  FROM [FeroApp].[dbo].[NarudzbeSta]

  select id_pro,brojrn1
  from narudzbesta n
  where brojrn1 in ( 
'08/1515',
'08/1526',
'08/1592',
'08/1601',
'08/1656',
'08/1658',
'08/1672',
'08/1673',
'08/1620',
'08/1653',
'08/1654',
'08/1683',
'08/1535',
'08/1572',
'08/1582',
'08/1606'
)

