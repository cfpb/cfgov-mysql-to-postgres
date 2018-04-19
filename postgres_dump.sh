#!/usr/bin/env bash

PGPASSWORD=cfgov pg_dump -c -U cfgov cfgov | gzip > /host/postgres.sql.gz
