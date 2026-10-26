with source as (
    select * from {{ source('raw', "csv_rows") }}
),

filtered as (
    select *
    from source
    where
        transaction_time is not null
        and amount > 0
        and post_code > 0
        and population_city > 0
),

normalized as (
    select
        transaction_time,
        lower(trimBoth(merch)) as merch,
        lower(trimBoth(cat_id)) as cat_id,
        amount,
        {{ segment_by_quantile('amount', 4, 'cat_id') }} as amount_segment,
        lower(name_1) as name_1,
        lower(name_2) as name_2,
        lower(replaceRegexpAll(trimBoth(street), '\\s+', ' ')) as street,
        lower(trimBoth(one_city)) as city,
        upper(us_state) as us_state,
        post_code,
        lat,
        lon,
        population_city,
        lower(trimBoth(jobs)) as job,
        merchant_lat,
        merchant_lon,
        target
    from filtered
)

select *
from normalized
order by transaction_time asc, merch asc, name_1 asc, amount desc
limit 1 by transaction_time, merch, name_1
