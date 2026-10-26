select
    mart_total,
    stg_total
from (
    select
        (select sum(total_amount) from {{ ref('mart_daily_state_metrics') }}) as mart_total,
        (select sum(amount) from {{ ref('stg_transactions') }}) as stg_total
)
where abs(mart_total - stg_total) > 0.01
