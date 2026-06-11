#!/bin/sh
set -e
set -e

cd /workdir

echo "Usage:"
echo " cargo --version              # Show cargo version"
echo " cargo init --name hello      # Create new your urst package"
echo " cat Cargo.toml               # Let's look Cargo.toml"
echo " cat src/main.rs              # Let's look main.rc"
echo " cargo build|b                # Build Your rust packaghe in debug mode"
echo " cargo build|b --release|-r   # Build Your rust packaghe in release mode"
echo " ./target/release/hello       # Run execute binary for release"
echo " ./target/debug/hello         # Run execute binary for debug"
echo " cargo check|c                # Check Your rust packaghe"
echo " cargo run                    # Run your rust package"
echo " cargo run -q                 # Run your rust package with secret"
echo " cargo fmt                    # Fortmat your rust code"

mkdir -p /etc/sudoers.d/
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu

usermod  -u "${HOST_GID}" ubuntu
groupmod -g "${HOST_GID}" ubuntu

chown -R ubuntu:ubuntu /home/ubuntu

if [ $# -gt 0 ]; then
    exec gosu ubuntu "$@"
else
    exec gosu ubuntu bash -i
fi
