-- brisanje dupli redova
-- 
   WITH CTE AS(

   SELECT id,prezime,ime , ROW_NUMBER()OVER(PARTITION BY id ORDER BY id) as rn
   FROM rdupli
)
DELETE FROM CTE WHERE RN > 1


---------------
--