import os

SECRET_KEY = os.environ["SUPERSET_SECRET_KEY"]

SQLALCHEMY_DATABASE_URI = (
    f"postgresql+psycopg2://{os.environ['SUPERSET_DB_USER']}:"
    f"{os.environ['SUPERSET_DB_PASSWORD']}@superset-db:5432/"
    f"{os.environ['SUPERSET_DB_NAME']}"
)