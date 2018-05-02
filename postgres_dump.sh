#!/usr/bin/env bash

# Dumps contents of Postgres database to file. Uses these options:
#
# --clean: Drops existing objects before loading them.
# --if-exists: Uses IF EXISTS statements when dropping objects.
# --no-owner: Don't retain existing object ownership.
# --no-privileges: Don't include privilege statements from database.
# --schema=cfpb: Only dump cfpb schema (exclude public).
# --user=cfpb: Connect to database as cfpb user.
PGPASSWORD=cfpb pg_dump \
    --clean \
    --if-exists \
    --no-owner \
    --no-privileges \
    --schema=cfpb \
    --user=cfpb \
    cfpb \
    | gzip > /host/postgres.sql.gz
