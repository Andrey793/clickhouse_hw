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