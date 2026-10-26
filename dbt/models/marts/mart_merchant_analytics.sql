{{
    config(order_by='(merch)')
}}
with merchants as (
    select
        merch,
        sum(amount) as total_amount,
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
    m.total_amount,
    m.fraud_rate,
    m.fraud_rate > t.p75_fraud_rate as risk_flag
from merchants as m
cross join risk_threshold as t
