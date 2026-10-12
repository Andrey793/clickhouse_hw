#!/usr/bin/env bash
# wait for data to finish loading
set -euo pipefail

CH="docker exec clickhouse clickhouse-client --password secret"
INTERVAL=5        
STABLE_CHECKS=3
TIMEOUT=600       

prev=-1
stable=0
waited=0

echo "Waiting for data to finish loading..."
while true; do
  count=$($CH --query "SELECT count() FROM default.csv_rows")
  state=$(docker compose ps -a --format '{{.State}}' producer)
  echo "  rows: $count, producer: $state"

  # count only as stable once the producer has finished and nothing new arrived
  if [[ "$state" == "exited" && "$count" -gt 0 && "$count" == "$prev" ]]; then
    stable=$((stable + 1))
  else
    stable=0
  fi

  if (( stable >= STABLE_CHECKS )); then
    break
  fi

  if (( waited >= TIMEOUT )); then
    echo "Timeout: data did not finish loading in ${TIMEOUT}s" >&2
    exit 1
  fi

  prev=$count
  sleep "$INTERVAL"
  waited=$((waited + INTERVAL))
done

echo "Loaded $count rows. Running query..."
docker exec -i clickhouse clickhouse-client --password secret --format CSVWithNames \
  < clickhouse/task.sql > result.csv
echo "Saved result.csv"