-- storage table
CREATE TABLE IF NOT EXISTS default.csv_rows
(
    transaction_time DateTime               CODEC(ZSTD(3)),
    merch            String                 CODEC(ZSTD(3)),
    cat_id           LowCardinality(String),
    amount           Float64                CODEC(ZSTD(3)),
    name_1           String                 CODEC(ZSTD(3)),
    name_2           String                 CODEC(ZSTD(3)),
    gender           Enum8('M' = 0, 'F' = 1),
    street           String                 CODEC(ZSTD(3)),
    one_city         String                 CODEC(ZSTD(3)),
    us_state         LowCardinality(String),
    post_code        UInt32                 CODEC(T64, ZSTD(3)),
    lat              Float32                CODEC(ZSTD(3)),
    lon              Float32                CODEC(ZSTD(3)),
    population_city  UInt32                 CODEC(T64, ZSTD(3)),
    jobs             String                 CODEC(ZSTD(3)),
    merchant_lat     Float32                CODEC(ZSTD(3)),
    merchant_lon     Float32                CODEC(ZSTD(3)),
    target           UInt8                  CODEC(ZSTD(3))
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(transaction_time)
ORDER BY (gender, us_state, cat_id);

-- kafka pipe
CREATE TABLE IF NOT EXISTS default.csv_rows_queue
(
    transaction_time String,
    merch       String,
    cat_id     String,
    amount     String,
    name_1     String,
    name_2     String,
    gender     String,
    street     String,
    one_city   String,
    us_state   String,
    post_code  String,
    lat        String,
    lon        String,
    population_city String,
    jobs       String,
    merchant_lat String,
    merchant_lon String,
    target     String,
)
ENGINE = Kafka
SETTINGS
    kafka_broker_list   = 'kafka:19092',          
    kafka_topic_list    = 'csv_rows',             
    kafka_group_name    = 'clickhouse_csv_rows',  
    kafka_format        = 'JSONEachRow',          
    kafka_num_consumers = 1;                      


CREATE MATERIALIZED VIEW IF NOT EXISTS default.csv_rows_mv
TO default.csv_rows
AS
SELECT
    parseDateTimeBestEffortOrNull(transaction_time) AS transaction_time,
    merch,
    cat_id,
    toFloat64(amount)          AS amount,
    name_1,
    name_2,
    gender,
    street,
    one_city,
    us_state,
    toUInt32(post_code)        AS post_code,
    toFloat32(lat)             AS lat,
    toFloat32(lon)             AS lon,
    toUInt32(population_city)  AS population_city,
    jobs,
    toFloat32(merchant_lat)    AS merchant_lat,
    toFloat32(merchant_lon)    AS merchant_lon,
    toUInt8(target)            AS target
FROM default.csv_rows_queue;