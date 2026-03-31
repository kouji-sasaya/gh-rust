#!/bin/sh
set -e

cd /workdir


echo "Usage:"
echo " cargo init    # Create new your urst package"
echo " cargo build   $ Build Your rust packaghe"
echo " cargo run     # Run your rust package"
echo " cargo fmt     # Fortmat your rust code"

if [ $# -gt 0 ]; then
    exec "$@"
else
    exec bash -i
fi
