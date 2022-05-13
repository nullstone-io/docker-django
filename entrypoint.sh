#!/bin/sh

set -e

export ECS_PRIVATE_IPS=$(wget -qO- "${ECS_CONTAINER_METADATA_URI}" | jq -r '.Networks | map(.IPv4Addresses) | flatten | join(",")')

# Configure DATABASE_URL if POSTGRES_URL is set
if [ -n "${POSTGRES_URL}" ]; then
  echo "Setting DB_ADAPTER=postgresql"
  export DB_ADAPTER=postgresql
  echo "Configuring SQLALCHEMY_DATABASE_URI using POSTGRES_URL"
  export SQLALCHEMY_DATABASE_URI="${POSTGRES_URL}"
  echo "Configuring DATABASE_URL using POSTGRES_URL"
  export DATABASE_URL="${MYSQL_URL}"
fi

# Configure DATABASE_URL if MYSQL_URL is set
if [ -n "${MYSQL_URL}" ]; then
  echo "Setting DB_ADAPTER=mysql"
  export DB_ADAPTER=mysql
  echo "Configuring SQLALCHEMY_DATABASE_URI using MYSQL_URL"
  export SQLALCHEMY_DATABASE_URI="${MYSQL_URL}"
  echo "Configuring DATABASE_URL using MYSQL_URL"
  export DATABASE_URL="${MYSQL_URL}"
fi

exec "$@"
