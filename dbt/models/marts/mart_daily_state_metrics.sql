{{
    config(order_by='(us_state)')
}}

select
    us_state,
    toDate(transaction_time) as trans_date,
    count(transaction_time) as trans_number,
    sum(amount) as total_amount,
    avg(amount) as avg_amount,
    quantile(0.95) (amount) as p95,
    countIf(amount_segment = 4) / count(transaction_time) as big_trans_fraction
from {{ ref("stg_transactions") }}
group by us_state, toDate(transaction_time)
