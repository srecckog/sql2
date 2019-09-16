use feroimpex
update [fxserver].[rfind].dbo.radnici_2
set 
ulica=left(j.acstreet,55),grad=left(j.accity,30),posta=right(j.acPost,6)

from 
(
--use feroimpex
select acworker,acregno,acsurname,acname,[acpost],acstreet,acphone,acCity
from thr_prsn p
left join [fxserver].[rfind].dbo.radnici_2 r on r.id=p.acRegNo
) j
left join [fxserver].[rfind].dbo.radnici_2 r2 on r2.id=j.acregno
--where r2.id=j.acregno



use [To-Ka-Bu doo]


update [fxserver].[rfind].dbo.radnici_2
set 
ulica=left(j.acstreet,55),grad=left(j.accity,30),posta=right(j.acPost,6)

from 
(
--use feroimpex
select acworker,acregno,acsurname,acname,[acpost],acstreet,acphone,acCity
from thr_prsn p
left join [fxserver].[rfind].dbo.radnici_2 r on r.id=p.acRegNo
) j
left join [fxserver].[rfind].dbo.radnici_2 r2 on r2.id=j.acregno



