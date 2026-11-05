{{
    config(order_by='(day_of_week, trans_hour)')
}}

select
    {{ dbt_date.day_of_week("transaction_time") }} as day_of_week,
    -- "1 Mon" ... "7 Sun": sorts correctly as text on chart axes
    concat(
        toString({{ dbt_date.day_of_week("transaction_time") }}),
        ' ',
        any(dateName('weekday', transaction_time))
    ) as day_label,
    toHour(transaction_time) as trans_hour,
    count() as total_trans,
    countIf(target = 1) as fraud_trans,
    avg(target = 1) as fraud_rate,
    sum(amount) filter (where target = 1) as fraud_amount
from {{ ref('stg_transactions') }}
group by {{ dbt_date.day_of_week("transaction_time") }}, toHour(transaction_time)
