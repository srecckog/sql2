SELECT R.ID_RADNIKA,r.id_fink,R.IME,a.ID,a.prezime
FROM FEROAPP.DBO.RADNICI R
LEFT JOIN RFIND.DBO.RADNICI_ A ON R.ID_FINK=A.ID



update radnici_ set id_radnika=j.id_radnika
from 
(
SELECT R.ID_RADNIKA,r.id_fink,R.IME,a.ID,a.prezime,id_firme
FROM FEROAPP.DBO.RADNICI R
LEFT JOIN RFIND.DBO.RADNICI_ A ON R.ID_FINK=A.ID
where a.poduzece like '%Feroimpex%' and r.id_firme=1
and a.id<8000 and a.id>1619
) j
inner join radnici_ r on r.id=j.id
where r.poduzece like '%Feroimpex%' and j.id_firme=1
and r.id<8000 and r.id>1619



