USE [RFIND]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_Kompetencije1]
		@id1 = 8065,
		@pod1 = 3

SELECT	'Return Value' = @return_value

GO


select *
from kompetencije
where id=65

update kompetencije set id=65 where id=8065


select *
from stat_bo2
where id=477


select *
from plansatirada
where radnikid=477
and godina=2016


select * into kompetencije_1306
from kompetencije










select *
from kompetencije
where id=65