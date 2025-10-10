# gh-rust

A GitHub CLI extension written in Rust.

## Description

This is a simple Hello World GitHub CLI extension implemented in Rust.

## Installation

```bash
gh extension install <your-username>/gh-rust
```

## Usage

```bash
gh rust
```

## Development

### Prerequisites

- Rust (latest stable version)
- Cargo

### Building

To build the project:

```bash
cargo build
```

To run the program:

```bash
cargo run
```

To build for distribution:

```bash
./script/build.sh
```

This will create a binary in the `dist/` directory for your platform.

## Project Structure

```
gh-rust/
├── src/
│   └── main.rs          # Main application code
├── script/
│   └── build.sh         # Build script for GitHub CLI extension
├── Cargo.toml           # Rust project configuration
└── README.md            # This file
```