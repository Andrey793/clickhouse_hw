{{
    config(order_by='(name_1, name_2)')
}}

select
    name_1,
    name_2,
    concat(name_1, ' ', name_2) as customer,
    argMax(us_state, transaction_time) as us_state,
    argMax(city, transaction_time) as city,
    argMax(job, transaction_time) as job,
    argMax(lat, transaction_time) as lat,
    argMax(lon, transaction_time) as lon,
    min(transaction_time) as first_trans_time,
    max(transaction_time) as last_trans_time,
    count(*) as total_trans,
    countIf(target = 1) as fraud_trans,
    max(amount) as max_amount,
    sum(amount) as total_amount,
    sumIf(amount, target = 1) as fraud_amount,
    avg(amount) as avg_amount,
    avg(target = 1) as fraud_rate,
    multiIf(
        avg(target = 1) < {{ var('risk_thr_low') }}, 'low',
        avg(target = 1) < {{ var('risk_thr_med') }}, 'medium',
        'high'
    ) as risk_lvl
from {{ ref('stg_transactions') }}
group by name_1, name_2
