import os
import uuid

from superset.app import create_app
from sqlalchemy.engine import URL

CONNECTION_UUID = uuid.UUID("f1f07b33-8650-4166-898f-905669d9574d")
CONNECTION_NAME = "ClickHouse"

app = create_app()

with app.app_context():
    from superset import db
    from superset.models.core import Database

    uri = URL.create(
        drivername="clickhousedb",
        username=os.environ["CH_USER"],
        password=os.environ["CH_PASSWORD"],
        host=os.environ.get("CH_HOST", "clickhouse"),
        port=int(os.environ.get("CH_PORT", "8123")),
        database=os.environ.get("CH_DATABASE") or None,
    )

    database = (
        db.session.query(Database).filter_by(uuid=CONNECTION_UUID).one_or_none()
        or db.session.query(Database).filter_by(database_name=CONNECTION_NAME).one_or_none()
    )
    action = "Updated"
    if database is None:
        database = Database(database_name=CONNECTION_NAME)
        db.session.add(database)
        action = "Created"

    database.uuid = CONNECTION_UUID
    database.database_name = CONNECTION_NAME
    database.set_sqlalchemy_uri(uri.render_as_string(hide_password=False))
    database.expose_in_sqllab = True
    db.session.commit()

    print(f"{action} database connection '{CONNECTION_NAME}' ({CONNECTION_UUID})")
