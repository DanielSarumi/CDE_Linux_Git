SELECT 
    r.name as region_name,
    s.name as sales_rep_name,
    a.name as account_name

FROM 
    region r 
    LEFT JOIN sales_reps s
    ON r.id = s.region_id
    LEFT JOIN accounts a
    ON s.id = a.sales_rep_id

ORDER BY 
    a.name