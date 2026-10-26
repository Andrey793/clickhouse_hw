логи dbt test
```
Running with dbt=1.10.23
08:06:01  This version of dbt is deprecated and no longer receives regular patches, including for known bugs. We recommend upgrading to a newer supported version of dbt: https://docs.getdbt.com/docs/dbt-versions
08:06:01  Registered adapter: clickhouse=1.10.3
08:06:01  Found 7 models, 29 data tests, 1 source, 985 macros, 3 unit tests
08:06:01  
08:06:01  Concurrency: 4 threads (target='dev')
08:06:01  
08:06:02  1 of 32 START test accepted_values_stg_transactions_amount_segment__False__1__2__3__4  [RUN]
08:06:02  2 of 32 START test accepted_values_stg_transactions_cat_id__entertainment__food_dining__gas_transport__grocery_net__grocery_pos__health_fitness__home__kids_pets__misc_net__misc_pos__personal_care__shopping_net__shopping_pos__travel  [RUN]
08:06:02  3 of 32 START test accepted_values_stg_transactions_target__False__0__1 ........ [RUN]
08:06:02  4 of 32 START test assert_daily_state_totals_match_staging ..................... [RUN]
08:06:04  3 of 32 PASS accepted_values_stg_transactions_target__False__0__1 .............. [PASS in 2.47s]
08:06:04  5 of 32 START test assert_risk_lvl_matches_thresholds .......................... [RUN]
08:06:04  5 of 32 PASS assert_risk_lvl_matches_thresholds ................................ [PASS in 0.02s]
08:06:04  6 of 32 START test dbt_expectations_expect_column_values_to_be_between_mart_daily_state_metrics_big_trans_fraction__1__0  [RUN]
08:06:04  6 of 32 PASS dbt_expectations_expect_column_values_to_be_between_mart_daily_state_metrics_big_trans_fraction__1__0  [PASS in 0.03s]
08:06:04  7 of 32 START test dbt_expectations_expect_column_values_to_be_between_mart_hourly_fraud_pattern_day_of_week__7__1  [RUN]
08:06:04  7 of 32 PASS dbt_expectations_expect_column_values_to_be_between_mart_hourly_fraud_pattern_day_of_week__7__1  [PASS in 0.02s]
08:06:04  8 of 32 START test dbt_expectations_expect_column_values_to_be_between_mart_hourly_fraud_pattern_trans_hour__23__0  [RUN]
08:06:04  8 of 32 PASS dbt_expectations_expect_column_values_to_be_between_mart_hourly_fraud_pattern_trans_hour__23__0  [PASS in 0.02s]
08:06:04  9 of 32 START test dbt_expectations_expect_column_values_to_be_between_stg_transactions_amount__0__True  [RUN]
08:06:04  2 of 32 PASS accepted_values_stg_transactions_cat_id__entertainment__food_dining__gas_transport__grocery_net__grocery_pos__health_fitness__home__kids_pets__misc_net__misc_pos__personal_care__shopping_net__shopping_pos__travel  [PASS in 2.79s]
08:06:04  10 of 32 START test dbt_expectations_expect_column_values_to_be_between_stg_transactions_lat__90___90  [RUN]
08:06:05  4 of 32 PASS assert_daily_state_totals_match_staging ........................... [PASS in 3.23s]
08:06:05  11 of 32 START test dbt_expectations_expect_column_values_to_be_between_stg_transactions_lon__180___180  [RUN]
08:06:05  1 of 32 PASS accepted_values_stg_transactions_amount_segment__False__1__2__3__4  [PASS in 3.31s]
08:06:05  12 of 32 START test dbt_expectations_expect_column_values_to_be_between_stg_transactions_merchant_lat__90___90  [RUN]
08:06:05  9 of 32 PASS dbt_expectations_expect_column_values_to_be_between_stg_transactions_amount__0__True  [PASS in 1.32s]
08:06:05  13 of 32 START test dbt_expectations_expect_column_values_to_be_between_stg_transactions_merchant_lon__180___180  [RUN]
08:06:06  10 of 32 PASS dbt_expectations_expect_column_values_to_be_between_stg_transactions_lat__90___90  [PASS in 1.40s]
08:06:06  14 of 32 START test dbt_expectations_expect_compound_columns_to_be_unique_stg_transactions_transaction_time__merch__name_1__name_2  [RUN]
08:06:06  11 of 32 PASS dbt_expectations_expect_column_values_to_be_between_stg_transactions_lon__180___180  [PASS in 1.50s]
08:06:06  15 of 32 START test dbt_utils_unique_combination_of_columns_mart_customer_risk_profile_name_1__name_2  [RUN]
08:06:06  15 of 32 PASS dbt_utils_unique_combination_of_columns_mart_customer_risk_profile_name_1__name_2  [PASS in 0.04s]
08:06:06  16 of 32 START test dbt_utils_unique_combination_of_columns_mart_daily_state_metrics_us_state__trans_date  [RUN]
08:06:06  16 of 32 PASS dbt_utils_unique_combination_of_columns_mart_daily_state_metrics_us_state__trans_date  [PASS in 0.04s]
08:06:06  17 of 32 START test dbt_utils_unique_combination_of_columns_mart_fraud_by_category_cat_id  [RUN]
08:06:06  17 of 32 PASS dbt_utils_unique_combination_of_columns_mart_fraud_by_category_cat_id  [PASS in 0.03s]
08:06:06  18 of 32 START test dbt_utils_unique_combination_of_columns_mart_fraud_by_state_us_state  [RUN]
08:06:06  18 of 32 PASS dbt_utils_unique_combination_of_columns_mart_fraud_by_state_us_state  [PASS in 0.04s]
08:06:06  19 of 32 START test dbt_utils_unique_combination_of_columns_mart_hourly_fraud_pattern_day_of_week__trans_hour  [RUN]
08:06:07  19 of 32 PASS dbt_utils_unique_combination_of_columns_mart_hourly_fraud_pattern_day_of_week__trans_hour  [PASS in 0.03s]
08:06:07  20 of 32 START test dbt_utils_unique_combination_of_columns_mart_merchant_analytics_merch  [RUN]
08:06:07  20 of 32 PASS dbt_utils_unique_combination_of_columns_mart_merchant_analytics_merch  [PASS in 0.03s]
08:06:07  21 of 32 START test not_null_stg_transactions_amount ........................... [RUN]
08:06:07  21 of 32 PASS not_null_stg_transactions_amount ................................. [PASS in 0.05s]
08:06:07  22 of 32 START test not_null_stg_transactions_amount_segment ................... [RUN]
08:06:07  22 of 32 PASS not_null_stg_transactions_amount_segment ......................... [PASS in 0.05s]
08:06:07  23 of 32 START test not_null_stg_transactions_cat_id ........................... [RUN]
08:06:07  23 of 32 PASS not_null_stg_transactions_cat_id ................................. [PASS in 0.03s]
08:06:07  24 of 32 START test not_null_stg_transactions_merch ............................ [RUN]
08:06:07  24 of 32 PASS not_null_stg_transactions_merch .................................. [PASS in 0.03s]
08:06:07  25 of 32 START test not_null_stg_transactions_name_1 ........................... [RUN]
08:06:07  25 of 32 PASS not_null_stg_transactions_name_1 ................................. [PASS in 0.05s]
08:06:07  26 of 32 START test not_null_stg_transactions_name_2 ........................... [RUN]
08:06:07  12 of 32 PASS dbt_expectations_expect_column_values_to_be_between_stg_transactions_merchant_lat__90___90  [PASS in 1.91s]
08:06:07  27 of 32 START test not_null_stg_transactions_target ........................... [RUN]
08:06:07  26 of 32 PASS not_null_stg_transactions_name_2 ................................. [PASS in 0.04s]
08:06:07  28 of 32 START test not_null_stg_transactions_transaction_time ................. [RUN]
08:06:07  27 of 32 PASS not_null_stg_transactions_target ................................. [PASS in 0.13s]
08:06:07  29 of 32 START test not_null_stg_transactions_us_state ......................... [RUN]
08:06:07  28 of 32 PASS not_null_stg_transactions_transaction_time ....................... [PASS in 0.12s]
08:06:07  30 of 32 START unit_test mart_customer_risk_profile::test_risk_lvl_thresholds .. [RUN]
08:06:07  29 of 32 PASS not_null_stg_transactions_us_state ............................... [PASS in 0.06s]
08:06:07  31 of 32 START unit_test mart_fraud_by_category::test_fraud_by_category_amounts  [RUN]
08:06:07  13 of 32 PASS dbt_expectations_expect_column_values_to_be_between_stg_transactions_merchant_lon__180___180  [PASS in 1.69s]
08:06:07  32 of 32 START unit_test mart_merchant_analytics::test_merchant_risk_flag ...... [RUN]
08:06:07  31 of 32 PASS mart_fraud_by_category::test_fraud_by_category_amounts ........... [PASS in 0.25s]
08:06:07  30 of 32 PASS mart_customer_risk_profile::test_risk_lvl_thresholds ............. [PASS in 0.32s]
08:06:07  32 of 32 PASS mart_merchant_analytics::test_merchant_risk_flag ................. [PASS in 0.16s]
08:06:08  14 of 32 PASS dbt_expectations_expect_compound_columns_to_be_unique_stg_transactions_transaction_time__merch__name_1__name_2  [PASS in 2.09s]
08:06:08  
08:06:08  Finished running 29 data tests, 3 unit tests in 0 hours 0 minutes and 6.56 seconds (6.56s).
08:06:08  
08:06:08  Completed successfully
08:06:08  
08:06:08  Done. PASS=32 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=32
```