#!/usr/bin/env bash

set -e

# Create dist directory
mkdir -p dist

# Determine platform and architecture
PLATFORM=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# Map architecture names
case "$ARCH" in
    x86_64) ARCH="amd64" ;;
    aarch64|arm64) ARCH="arm64" ;;
esac

# Set target for cross-compilation if needed
case "$PLATFORM-$ARCH" in
    linux-amd64) TARGET="x86_64-unknown-linux-gnu" ;;
    linux-arm64) TARGET="aarch64-unknown-linux-gnu" ;;
    darwin-amd64) TARGET="x86_64-apple-darwin" ;;
    darwin-arm64) TARGET="aarch64-apple-darwin" ;;
    *) echo "Unsupported platform: $PLATFORM-$ARCH"; exit 1 ;;
esac

# Build the binary
echo "Building for $PLATFORM-$ARCH (target: $TARGET)"
cargo build --release --target "$TARGET"

# Copy binary to dist directory
BINARY_NAME="gh-rust"
if [ "$PLATFORM" = "windows" ]; then
    BINARY_NAME="gh-rust.exe"
fi

cp "target/$TARGET/release/$BINARY_NAME" "dist/$PLATFORM-$ARCH"
if [ "$PLATFORM" = "windows" ]; then
    mv "dist/$PLATFORM-$ARCH" "dist/$PLATFORM-$ARCH.exe"
fi

echo "Binary built successfully: dist/$PLATFORM-$ARCH"
