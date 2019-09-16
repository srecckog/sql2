update kompetencije0305 set satnica=( select satnica from plansatirada ps where mjesec=3 and godina=2017 and ps.RadnikID=id)



UPDATE
    kompetencije0305
SET
    satnica = r.satnicakn
FROM
     kompetencije0305 k
INNER JOIN
    fxsap.dbo.plansatirada r	
ON 
    r.radnikid=k.id
	where mjesec=5 and godina=2017




	select *
	from Kompetencije0305
	where id=1206


	select count(*)
	from fxsap.dbo.plansatirada
	where mjesec=5 and godina=2017


	select id
	from kompetencije0305
	where id not in
	(
	select *
	from fxsap.dbo.plansatirada
	where mjesec=4 and godina=2017
	and radnikid=1206

		)
