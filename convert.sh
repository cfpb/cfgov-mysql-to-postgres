#!/usr/bin/env bash

# Run load script in MySQL container. This loads MySQL container's database.
# Requires a local file named "production_complete.sql".
docker-compose exec mysql /host/mysql_load.sh

# Use pgloader to copy MySQL data over to Postgres.
docker-compose run pgloader pgloader --debug --client-min-messages=debug /host/pgloader.conf

# Dump Postgres data to a new export called postgres.sql.
docker-compose exec postgres /host/postgres_dump.sh
