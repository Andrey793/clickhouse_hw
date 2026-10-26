.PHONY: up down deps run test build lint fix

DBT := docker compose exec -T dbt
# optional dbt node selection: make run s=mart_fraud_by_state
SELECT := $(if $(s),--select $(s))

up:
	docker compose up -d --build

down:
	docker compose down

deps:
	$(DBT) dbt deps

run:
	$(DBT) dbt run $(SELECT)

test:
	$(DBT) dbt test $(SELECT)

build:
	$(DBT) dbt build $(SELECT)

lint:
	$(DBT) sqlfluff lint models tests macros

fix:
	$(DBT) sqlfluff fix models tests macros
