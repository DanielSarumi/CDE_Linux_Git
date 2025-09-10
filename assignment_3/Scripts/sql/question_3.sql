SELECT 
    *
FROM
    accounts
WHERE 
    (name Like 'C%' OR name Like 'W%') AND ( (primary_poc like '%ana%' OR primary_poc like '%Ana%' ) AND primary_poc not like '%eana%' )