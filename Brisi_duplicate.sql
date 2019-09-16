WITH CTE AS(
   SELECT id,rv,poduzece,
       RN = ROW_NUMBER() OVER(PARTITION BY id ORDER BY id)
   FROM dbo.radnici_
)
delete  FROM CTE WHERE RN > 1



select * into rv1 FROM radnici_ WHERE rv > 1


update radnici_
set rv=j.rv
from
(
select id,rv
from rv1
) j
left join radnici_ r on r.id=j.id


select *
from radnici_
order by id



