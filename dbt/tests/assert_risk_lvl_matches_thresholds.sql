select
    name_1,
    name_2,
    fraud_rate,
    risk_lvl
from {{ ref('mart_customer_risk_profile') }}
where
    (fraud_rate < {{ var('risk_thr_low') }} and risk_lvl != 'low')
    or (fraud_rate >= {{ var('risk_thr_low') }} and fraud_rate < {{ var('risk_thr_med') }} and risk_lvl != 'medium')
    or (fraud_rate >= {{ var('risk_thr_med') }} and risk_lvl != 'high')
