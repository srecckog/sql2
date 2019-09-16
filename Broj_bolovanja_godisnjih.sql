use fxsap
select count(*) broj ,'Bolovanja' vrsta
from plansatirada
where mjesec=8 and godina=2017
and (dan01='8b' or dan02='8b' or dan03='8b' or dan04='8b' or dan05='8b' or dan06='8b' or  dan07='8b' or dan08='8b' or dan09='8b' or dan10='8b' or dan11='8b' or dan12='8b' or  
dan13='8b' or dan14='8b' or dan15='8b' or dan16='8b' or dan17='8b' or dan18='8b' or  dan19='8b' or dan20='8b' or dan21='8b' or dan22='8b' or dan23='8b' or dan24='8b' or  
dan25='8b' or dan26='8b' or dan27='8b' or dan28='8b' or dan29='8b' or dan30='8b' or  dan31='8b' )
and radnikid=1276
union all
select count(*) broj ,'Godisnji' vrsta
from plansatirada
where mjesec=8 and godina=2017
and (dan01 in ('7g','5g') or dan02 in ('7g','5g') or dan03 in ('7g','5g') or dan04 in ('7g','5g') or dan05 in ('7g','5g') or dan06 in ('7g','5g') or  dan07 in ('7g','5g') or dan08 in ('7g','5g') or dan09 in ('7g','5g') or dan10 in ('7g','5g') or dan11 in ('7g','5g') or dan12 in ('7g','5g') or  
dan13 in ('7g','5g') or dan14 in ('7g','5g') or dan15 in ('7g','5g') or dan16 in ('7g','5g') or dan17 in ('7g','5g') or dan18 in ('7g','5g') or  dan19 in ('7g','5g') or dan20 in ('7g','5g') or dan21 in ('7g','5g') or dan22 in ('7g','5g') or dan23 in ('7g','5g') or dan24 in ('7g','5g') or  
dan25 in ('7g','5g') or dan26 in ('7g','5g') or dan27 in ('7g','5g') or dan28 in ('7g','5g') or dan29 in ('7g','5g') or dan30 in ('7g','5g') or  dan31 in ('7g','5g') )
and radnikid=1276
union all
select count(*) broj ,'Neopravdano' vrsta
from plansatirada
where mjesec=8 and godina=2017
and (dan01 in ('0e') or dan02 in ('0e') or dan03 in ('0e') or dan04 in ('0e') or dan05 in ('0e') or dan06 in ('0e') or  dan07 in ('0e') or dan08 in ('0e') or dan09 in ('0e') or dan10 in ('0e') or dan11 in ('0e') or dan12 in ('0e') or  
dan13 in ('0e') or dan14 in ('0e') or dan15 in ('0e') or dan16 in ('0e') or dan17 in ('0e') or dan18 in ('0e') or  dan19 in ('0e') or dan20 in ('0e') or dan21 in ('0e') or dan22 in ('0e') or dan23 in ('0e') or dan24 in ('0e') or  
dan25 in ('0e') or dan26 in ('0e') or dan27 in ('0e') or dan28 in ('0e') or dan29 in ('0e') or dan30 in ('0e') or  dan31 in ('0e') )
and radnikid=1276