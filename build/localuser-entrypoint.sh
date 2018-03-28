#!/bin/bash

set -e
set -x

/set-mysql-uid-gid.sh
/entrypoint.sh $@
