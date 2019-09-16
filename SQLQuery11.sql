	 select smjena ,sum(kolicinaok) kolicina,sum(norma) norma
  from feroapp.dbo.evidnormi( DATEADD(day,-5,getdate()),DATEADD(day,-5,getdate()),0)
  where hala=1 and kolicinaok>0
  group by smjena
  order by smjena