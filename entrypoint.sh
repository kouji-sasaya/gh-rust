#!/bin/sh
set -e



if [ "$(id -un)" = "root" ]; then
  groupmod -g "${HOST_GID}" ubuntu
  usermod  -u "${HOST_UID}" -g "${HOST_GID}" ubuntu
  chown -R ubuntu:ubuntu /home/ubuntu
  echo "exec su - ubuntu" >> ~/.bashrc
  exec gosu ubuntu ${0}
  exit 0
fi


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

export CARGO_HOME=/home/ubuntu/.cargo
cd /workdir
if [ $# -gt 0 ]; then
    exec "$@"
else
    exec bash -i
fi
