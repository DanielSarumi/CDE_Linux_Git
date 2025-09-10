SELECT
    *
FROM 
    orders
WHERE
    standard_qty = 0 and (gloss_qty > 1000 OR poster_qty  > 1000)