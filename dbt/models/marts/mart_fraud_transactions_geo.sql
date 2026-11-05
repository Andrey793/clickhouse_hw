{{
    config(order_by='(transaction_time)')
}}

select
    transaction_time,
    merch,
    cat_id,
    amount,
    us_state,
    city,
    lat as customer_lat,
    lon as customer_lon,
    merchant_lat,
    merchant_lon,
    toDate(transaction_time) as trans_date,
    concat(name_1, ' ', name_2) as customer,
    round(greatCircleDistance(lon, lat, merchant_lon, merchant_lat) / 1000, 1) as distance_km
from {{ ref('stg_transactions') }}
where target = 1
