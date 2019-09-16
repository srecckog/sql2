select ime,sum(brojdanagodisnjeg) BrojDanaGodišnjeg 
from(

select ime, mjesec, (LEN(dani) - LEN(REPLACE(dani, 'g', ''))) brojdanagodisnjeg 
from( 

select ime, mjesec, radnikid, (isnull(dan01, '') + isnull(dan02, '') + isnull(dan03, '') + isnull(dan04, '') + isnull(dan05, '') + isnull(dan06, '') + isnull(dan07, '') + isnull(dan08, '') + isnull(dan09, '') + isnull(dan10, '') + isnull(dan11, '') + isnull(dan12, '') + isnull(dan13, '') + isnull(dan14, '') + isnull(dan15, '') + isnull(dan16, '') + isnull(dan17, '') + isnull(dan18, '') + isnull(dan19, '') + isnull(dan20, '') + isnull(dan21, '') + isnull(dan22, '') + isnull(dan23, '') + isnull(dan24, '') + isnull(dan25, '') + isnull(dan26, '') + isnull(dan27, '') + isnull(dan28, '') + isnull(dan29, '') + isnull(dan30, '') + isnull(dan31, '')) dani 

from fxsap.dbo.plansatirada where godina = 2019 and mjesec >= 1 and (dan01 like '%g'  or dan02 like '%g'  or dan03 like '%g'  or dan04 like '%g'  or dan05 like '%g'  or dan06 like '%g' or dan07 like '%g'  or dan08 like '%g' or dan09 like '%g'  or dan10 like '%g'  or dan11 like '%g'  or dan12 like '%g'  or dan13 like '%g' or dan14 like '%g'  or dan15 like '%g' or dan16 like '%g' or dan17 like '%g' or dan18 like '%g' or dan19 like '%g' or dan20 like '%g' or dan21 like '%g' or dan22 like '%g' or dan23 like '%g' or dan24 like '%g' or dan25 like '%g' or dan26 like '%g' or dan27 like '%g' or dan28 like '%g'  or dan29 like '%g'  or dan30 like '%g' or dan31 like '%g'  )  ) x1 ) x2 group by ime order by ime 