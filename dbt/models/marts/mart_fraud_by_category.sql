{{
    config(order_by='(cat_id)')
}}

select
    cat_id,
    count() as total_trans,
    countIf(target = 1) as fraud_trans,
    avg(target = 1) as fraud_rate,
    sum(amount) filter (where target = 1) as fraud_amount,
    sum(amount) filter (where target = 0) as legit_amount
from {{ ref('stg_transactions') }}
group by cat_id
