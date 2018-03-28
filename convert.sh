#!/usr/bin/env bash

# Fail if anything fails.
set -e

# Run load script in MySQL container. This loads MySQL container's database.
# Requires a local file named "mysql.sql.gz".
docker-compose exec -T mysql /host/mysql_load.sh

# Use pgloader to copy MySQL data over to Postgres.
docker-compose run -T pgloader pgloader --debug --client-min-messages=debug /host/pgloader.conf

# Dump Postgres data to a new export called postgres.sql.
docker-compose exec -T postgres /host/postgres_dump.sh
