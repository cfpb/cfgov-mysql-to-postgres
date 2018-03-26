#!/usr/bin/env bash

PGPASSWORD=cfgov pg_dump -U cfgov cfgov > /host/postgres.sql
