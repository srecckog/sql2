/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[Grupa]
      ,[prezime i ime]
      ,[pogon (ukloniti)]
      ,[funkcija]
      ,[vještine]
      ,[datum zaposlenja]
      ,[staž]
      ,[ima]
      ,[ne dolasci subotom]
      ,[ne dolasci subotom zadnji(4#)mjesec(22)]
      ,[% norme]
      ,[% norme zadnji mjesec]
      ,[rad vikendom]
      ,[rad vikendom zadnji mjesec(4)(9)]
      ,[ne dolasci vikendom        (a u planu je)]
      ,[ne dolasci vikendom (a u planu je) zadnji mjesec(4)(9)]
      ,[bolovanja (3#mj#)]
      ,[rad 12-12      (koliko dana)]
      ,[Stimulacija(bruto)]
      ,[napomena]
  FROM [RFIND].[dbo].[kompetence2]



  select r.id,r.prezime,r.ime,k.[prezime i ime]
  from 
  radnici_ r 
  left join kompetence k on k.[prezime i ime]=r.prezime+ ' '+ime
  where k.[prezime i ime] is null


  update kompetence k set id =(
  select r.id
  from 
  radnici_ r 
  left join kompetence k on k.[prezime i ime]=r.prezime+ ' '+ime
  where k.[prezime i ime] is not null
) 
where k.[prezime i ime]=r.prezime+ ' '+ime




UPDATE
    kompetence2 
SET
    [prezime i ime]=R.IME+ ' '+R.PREZIME
FROM
  radnici_ r 
  left join kompetence2 k on k.[prezime i ime]=r.IME+ ' '+PREZIME

WHERE
  k.[prezime i ime] is not null
  --and k.id=0
  AND K.Grupa=5






  select *
  from radnici_
  where prezime like '%KRULC%'