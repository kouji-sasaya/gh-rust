# syntax=docker/dockerfile:1

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gh \
    vim \
    rustc \
    cargo \
    rustfmt \
    build-essential \
    pkg-config \
    libssl-dev \
 && rm -rf /var/lib/apt/lists/*

RUN cargo install --locked --root /usr/local cargo-audit --version 0.21.1

WORKDIR /workdir

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
