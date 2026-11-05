{{
    config(order_by='(cat_id)')
}}

select
    cat_id,
    if(endsWith(cat_id, '_net'), 'online', 'offline') as channel,
    count() as total_trans,
    countIf(target = 1) as fraud_trans,
    avg(target = 1) as fraud_rate,
    sum(amount) as total_amount,
    avg(amount) as avg_amount,
    avgIf(amount, target = 1) as avg_fraud_amount,
    sum(amount) filter (where target = 1) as fraud_amount,
    sum(amount) filter (where target = 0) as legit_amount
from {{ ref('stg_transactions') }}
group by cat_id
