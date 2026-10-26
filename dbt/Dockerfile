FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir "dbt-core==1.10.*" "dbt-clickhouse==1.10.3" "sqlfluff" "sqlfluff-templater-dbt"

WORKDIR /usr/app/dbt
ENV DBT_PROFILES_DIR=/usr/app/dbt