select rbroj,datum,dosao,otisao,idradnika,PreranoOtisao,tdoci,totici,Ukupno_minuta,smjena
  from pregledvremena pv
  where datepart(dw, datum)=7
  and year(dosao)!=1900
  and PreranoOtisao<30  
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'

  
  
  update pregledvremena set PreranoOtisao=0 
  where datepart(dw, datum)=7
  and year(dosao)!=1900
  and month(datum)<=4
  and PreranoOtisao<30  and PreranoOtisao>0
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'

  


  select * into pregledvremena1605
  from PregledVremena
