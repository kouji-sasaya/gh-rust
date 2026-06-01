#!/bin/sh
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

run_cmd() {
    if [ $# -gt 0 ]; then
        exec "$@"
    else
        exec bash -i
    fi
}

if [ "$(id -u)" -eq 0 ]; then
    TARGET_USER=ferris
    TARGET_GROUP=ferris

    if [ -n "${HOST_GID:-}" ] && [ "$(id -g ${TARGET_USER})" != "${HOST_GID}" ]; then
        EXISTING_GROUP=$(getent group "${HOST_GID}" | cut -d: -f1 || true)
        if [ -n "${EXISTING_GROUP}" ]; then
            TARGET_GROUP="${EXISTING_GROUP}"
            usermod -g "${HOST_GID}" "${TARGET_USER}"
        else
            groupmod -g "${HOST_GID}" "${TARGET_GROUP}"
        fi
    fi

    if [ -n "${HOST_UID:-}" ] && [ "$(id -u ${TARGET_USER})" != "${HOST_UID}" ]; then
        EXISTING_USER=$(getent passwd "${HOST_UID}" | cut -d: -f1 || true)
        if [ -z "${EXISTING_USER}" ] || [ "${EXISTING_USER}" = "${TARGET_USER}" ]; then
            usermod -u "${HOST_UID}" "${TARGET_USER}"
        else
            echo "Warning: uid ${HOST_UID} is already used by ${EXISTING_USER}. Keeping ferris uid unchanged." >&2
        fi
    fi

    USER_HOME=$(getent passwd "${TARGET_USER}" | cut -d: -f6)
    export HOME="${USER_HOME}"

    if [ -n "${HOST_UID:-}" ] && [ -n "${HOST_GID:-}" ]; then
        chown -R "${HOST_UID}:${HOST_GID}" "${USER_HOME}" /workdir 2>/dev/null || true
    fi

    if [ -f /tmp/host_gitconfig ]; then
        mkdir -p "${USER_HOME}"
        cp /tmp/host_gitconfig "${USER_HOME}/.gitconfig"
        chown "$(id -u ${TARGET_USER}):$(id -g ${TARGET_USER})" "${USER_HOME}/.gitconfig"
    fi

    if [ $# -gt 0 ]; then
        exec gosu "${TARGET_USER}" "$@"
    else
        exec gosu "${TARGET_USER}" bash -i
    fi
fi

run_cmd "$@"
