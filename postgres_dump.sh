#!/usr/bin/env bash

PGPASSWORD=cfpb pg_dump -c -U cfpb cfpb | gzip > /host/postgres.sql.gz
