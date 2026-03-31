#!/bin/sh
set -e

cd /workdir

if [ $# -gt 0 ]; then
    exec "$@"
else
    exec bash -i
fi
