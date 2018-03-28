#!/usr/bin/env sh

set -e
set -x

HOST_VOLUME=/host

UID=$(stat -c %u $HOST_VOLUME)
GID=$(stat -c %g $HOST_VOLUME)

usermod -u $UID mysql && groupmod -g $GID mysql
