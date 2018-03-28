#!/usr/bin/env bash

PGPASSWORD=cfgov pg_dump -U cfgov cfgov | gzip > /host/postgres.sql.gz
