SELECT
    us_state,
    argMax(cat_id, amount)     AS top_cat_id
FROM default.csv_rows
WHERE amount IS NOT NULL
GROUP BY us_state