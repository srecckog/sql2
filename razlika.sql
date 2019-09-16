select pd.*
from rfind.dbo.popisdjelatnika_panth(0) pd
left join minorm m on m.id=pd.id and m.firma=pd.poduzece
where m.id is null