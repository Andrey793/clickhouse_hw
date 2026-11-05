{{
    config(order_by='(us_state, trans_date)')
}}

select
    us_state,
    concat('US-', us_state) as state_iso,
    toDate(transaction_time) as trans_date,
    count(transaction_time) as trans_number,
    countIf(target = 1) as fraud_trans,
    avg(target = 1) as fraud_rate,
    sum(amount) as total_amount,
    sumIf(amount, target = 1) as fraud_amount,
    avg(amount) as avg_amount,
    quantile(0.95) (amount) as p95,
    countIf(amount_segment = 4) / count(transaction_time) as big_trans_fraction
from {{ ref("stg_transactions") }}
group by us_state, toDate(transaction_time)
