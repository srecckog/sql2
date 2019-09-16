use feroapp
select n.*,p.* 
from narudzbesta n 
left join proizvodi p on n.ID_Pro=p.ID_Pro 
where n.BrojRN='1309/2018'

select * from evidencijanormista 
where brojrn='1309/2018'

select sum(s.KolicinaOK) as Ukol from evidencijaproizvodnjesta s 
left join evidencijaproizvodnjezag z on s.ID_EPZ=z.ID_EPZ 
where z.BrojRN='1309/2018'