SELECT
    us_state,
    argMax(cat_id, amount)     AS top_cat_id
FROM default.csv_rows
GROUP BY us_state