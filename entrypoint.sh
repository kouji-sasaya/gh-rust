#!/bin/sh
set -e

cd /workdir

# Keep Cargo cache writable for non-root execution.
if [ -z "${CARGO_HOME}" ]; then
    CARGO_HOME="/workdir/.cargo"
fi
export CARGO_HOME
mkdir -p "${CARGO_HOME}"

sanitize_cargo_config() {
    cfg="$1"
    if [ ! -f "${cfg}" ]; then
        return 0
    fi

    tmp="$(mktemp)"
    awk '
        /^\[.*\][[:space:]]*$/ { in_env = ($0 == "[env]") }
        { if (in_env && $0 ~ /^[[:space:]]*CARGO_HOME[[:space:]]*=/) next; print }
    ' "${cfg}" > "${tmp}"

    if ! cmp -s "${cfg}" "${tmp}"; then
        cp "${cfg}" "${cfg}.bak"
        mv "${tmp}" "${cfg}"
        echo "[gh-rust] removed unsupported CARGO_HOME entry from ${cfg}"
    else
        rm -f "${tmp}"
    fi
}

# Cargo rejects CARGO_HOME in [env], so auto-heal known config locations.
sanitize_cargo_config "/workdir/.cargo/config.toml"
sanitize_cargo_config "${CARGO_HOME}/config.toml"


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

if [ $# -gt 0 ]; then
    exec "$@"
else
    exec bash -i
fi
