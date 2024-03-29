/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_FZ]
      ,[KodFirme]
      ,[BrojFakture]
      ,[DatumFakture]
      ,[VrijemeFakture]
      ,[BrojProforme]
      ,[BrojOtpremnice]
      ,[DatumOtpremnice]
      ,[BrojSpecifikacije]
      ,[Razduzenje]
      ,[ID_Par]
      ,[ID_ParPF]
      ,[VrstaPlacanja]
      ,[DatumValute]
      ,[Valuta]
      ,[TecajValute]
      ,[PDV]
      ,[Rabat]
      ,[ZiroRN1]
      ,[ZiroRN2]
      ,[VrstaFakture]
      ,[InternaFaktura]
      ,[IspisiBrojNacrta]
      ,[IspisiPakiranja]
      ,[NeIspisujCijenuMaterijala]
      ,[Fakturirao]
      ,[Odobrio]
      ,[Napomena]
      ,[Paritet]
      ,[Placanje]
      ,[Transport]
      ,[Dostavnica]
      ,[Narudzba]
      ,[PozivNaBroj]
      ,[IspisiIzjavu]
      ,[Izjava]
      ,[Tarifa]
      ,[Isporuka1]
      ,[Isporuka2]
      ,[Isporuka3]
      ,[Isporuka4]
      ,[Isporuka5]
      ,[Jezik]
  FROM [FeroApp].[dbo].[FaktureZag] 


  select s.*
  from fakturezag z
  left join fakturesta s on s.ID_FZ=z.ID_FZ
  where datumfakture>='2017-03-01' and datumfakture<='2017-03-31'

