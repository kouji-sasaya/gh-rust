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

if [ "$(id -u)" -eq 0 ] && [ -n "${HOST_UID:-}" ] && [ -n "${HOST_GID:-}" ]; then
    GROUP_NAME=$(getent group "${HOST_GID}" | cut -d: -f1 || true)
    if [ -z "${GROUP_NAME}" ]; then
        GROUP_NAME=${HOST_GROUP:-hostgroup}
        if getent group "${GROUP_NAME}" >/dev/null 2>&1; then
            GROUP_NAME="hostgroup_${HOST_GID}"
        fi
        groupadd -g "${HOST_GID}" "${GROUP_NAME}"
    fi

    USER_NAME=$(getent passwd "${HOST_UID}" | cut -d: -f1 || true)
    if [ -z "${USER_NAME}" ]; then
        USER_NAME=${HOST_USER:-hostuser}
        if getent passwd "${USER_NAME}" >/dev/null 2>&1; then
            USER_NAME="hostuser_${HOST_UID}"
        fi
        useradd -m -u "${HOST_UID}" -g "${GROUP_NAME}" -s /bin/bash "${USER_NAME}"
    fi

    USER_HOME=$(getent passwd "${USER_NAME}" | cut -d: -f6)
    export HOME="${USER_HOME}"

    if [ -f /tmp/host_gitconfig ]; then
        mkdir -p "${USER_HOME}"
        cp /tmp/host_gitconfig "${USER_HOME}/.gitconfig"
        chown "${HOST_UID}:${HOST_GID}" "${USER_HOME}/.gitconfig"
    fi

    if [ $# -gt 0 ]; then
        exec gosu "${USER_NAME}" "$@"
    else
        exec gosu "${USER_NAME}" bash -i
    fi
fi

run_cmd "$@"
