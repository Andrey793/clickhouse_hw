Репозиторий состоит из 2 веток.

1. Main. Содержит базовую логику создания Clickhouse таблицы из потока транзакций из csv.
2. dbt. Дополняет первую версию dbt staging и marts моделями. Также содержит тесты для этих моделей.

Использование
```
git clone https://github.com/Andrey793/clickhouse_hw.git
cd clickhouse_hw
```
```
# В docker-compose.yaml замените .data на путь, по которому лежит train.csv
volumes:
      - <train.csv path>:/app/data
```
```
docker compose up -d
. run_query.sh
```

Скрипт ждет пока producer завершит работу и kafka выгрузит все данные в таблицу ClickHouse, после чего запускает sql запрос.
