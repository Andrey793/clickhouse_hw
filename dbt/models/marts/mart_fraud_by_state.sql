{{
    config(order_by='(us_state)')
}}

select
    us_state,
    avg(target = 1) as fraud_rate,
    uniqExact(merch) as unique_merchs,
    uniqExact(name_1, name_2) as unique_clients,
    sum(amount) filter (where target = 1) as fraud_amount,
    sum(amount) filter (where target = 0) as legit_amount
from {{ ref("stg_transactions") }}
group by us_state
