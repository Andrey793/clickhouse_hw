import csv
import json
import logging
import os
import sys

from confluent_kafka import Producer

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
log = logging.getLogger("producer")

# configuration
BOOTSTRAP_SERVERS = os.getenv("KAFKA_BOOTSTRAP_SERVERS", "localhost:9092")
TOPIC = os.getenv("KAFKA_TOPIC", "csv_rows")
CSV_PATH = os.getenv("CSV_PATH", "data.csv")

stats = {"ok": 0, "failed": 0}


def on_delivery(err, msg):
    """Called by the library once Kafka confirms (or rejects) a message."""
    if err is not None:
        stats["failed"] += 1
        log.error("Delivery failed: %s", err)
    else:
        stats["ok"] += 1


def main():
    producer = Producer({
        "bootstrap.servers": BOOTSTRAP_SERVERS,
        "acks": "all",               
        "enable.idempotence": True,  
        "linger.ms": 50,            
    })
    log.info("Sending %s to topic '%s' via %s", CSV_PATH, TOPIC, BOOTSTRAP_SERVERS)

    with open(CSV_PATH, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)  
        for i, row in enumerate(reader, start=1):
            value = json.dumps(row, ensure_ascii=False).encode("utf-8")

            while True:
                try:
                    producer.produce(TOPIC, value=value, on_delivery=on_delivery)
                    break
                except BufferError:
                    producer.poll(1)

            producer.poll(0)

            if i % 10_000 == 0:
                log.info("Queued %d rows", i)

    
    remaining = producer.flush(timeout=60)
    log.info("Done: %d delivered, %d failed, %d undelivered",
             stats["ok"], stats["failed"], remaining)

    if stats["failed"] or remaining:
        sys.exit(1)  

if __name__ == "__main__":
    main()