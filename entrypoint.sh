#!/bin/sh
set -e

cd /workdir


echo "Usage:"
echo " cargo init                 # Create new your urst package"
echo " cargo build|b              # Build Your rust packaghe in debug mode"
echo " cargo build|b --release|-r # Build Your rust packaghe in release mode"
echo " cargo check|c              # Check Your rust packaghe"
echo " cargo run                  # Run your rust package"
echo " cargo run -q               # Run your rust package with secret"
echo " cargo fmt                  # Fortmat your rust code"

if [ $# -gt 0 ]; then
    exec "$@"
else
    exec bash -i
fi
