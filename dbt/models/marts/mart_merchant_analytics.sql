{{
    config(order_by='(merch)')
}}
with merchants as (
    select
        merch,
        topK(1) (cat_id)[1] as main_category,
        avg(merchant_lat) as merchant_lat,
        avg(merchant_lon) as merchant_lon,
        count() as total_trans,
        countIf(target = 1) as fraud_trans,
        sum(amount) as total_amount,
        sumIf(amount, target = 1) as fraud_amount,
        avg(amount) as avg_amount,
        avg(target = 1) as fraud_rate
    from {{ ref('stg_transactions') }}
    group by merch
),

risk_threshold as (
    select quantileExact(0.75) (fraud_rate) as p75_fraud_rate
    from merchants
)

select
    m.merch,
    m.main_category,
    m.merchant_lat,
    m.merchant_lon,
    m.total_trans,
    m.fraud_trans,
    m.total_amount,
    m.fraud_amount,
    m.avg_amount,
    m.fraud_rate,
    m.fraud_rate > t.p75_fraud_rate as risk_flag,
    if(m.fraud_rate > t.p75_fraud_rate, 'high risk', 'normal') as risk_label
from merchants as m
cross join risk_threshold as t
