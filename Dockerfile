FROM python:3.9.1

WORKDIR /app

# Install wget
RUN apt-get update && apt-get install -y wget

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY ingest_data.py .
COPY taxi+_zone_lookup.csv .

ENTRYPOINT ["sh", "-c", "python ingest_data.py --user $POSTGRES_USER --password $POSTGRES_PASSWORD --host $POSTGRES_HOST --port $POSTGRES_PORT --db $POSTGRES_DB --table_name $TABLE_NAME --url $CSV_URL"]
