#!/usr/bin/env bash

zcat /host/mysql.sql.gz | mysql -u root --password=cfpb cfpb
