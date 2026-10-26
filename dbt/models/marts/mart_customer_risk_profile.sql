{{
    config(order_by='(name_1, name_2)')
}}

select
    name_1,
    name_2,
    count(*) as total_trans,
    max(amount) as max_amount,
    sum(amount) as total_amount,
    avg(amount) as avg_amount,
    avg(target = 1) as fraud_rate,
    multiIf(
        avg(target = 1) < {{ var('risk_thr_low') }}, 'low',
        avg(target = 1) < {{ var('risk_thr_med') }}, 'medium',
        'high'
    ) as risk_lvl
from {{ ref('stg_transactions') }}
group by name_1, name_2
