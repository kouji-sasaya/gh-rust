# gh-rust


GitHub extension で、rust のビルド環境を構築します。

## 説明

gh resut を使って、面倒な、環境構築を簡単にして、すぐに、rust プログラミング言語の学習ができます。

## インストール / アンインストール / アップグレード

```sh
gh ext install kouji-sasaya/gh-rust
```

```sh
gh ext remove kouji-sasaya/gh-rust
```

```sh
gh ext upgrade rust
```

## セットアップ

rust プログラミングの学習環境は、docker コンテナ内で、作業できます。

setup すると、docker ビルドします。


```sh
gh rust setup
```

## 学習

まっさらな、ディレクトリを作成し、hello worldを、rust コンパイラでビルドして、実行します。

デバッグ版のビルド方法と、リリース版のビルド方法を学びます。

フォーマッターを使って、rust コードを成形できます。

### docker コンテナに入る

```sh
mkdir my-rust && cd my-rust
gh rust shell
```

### Building

hello world作成

```sh
cargo init
```

ビルド（デバッグ版）

```sh
cargo build
```

ビルド（リリース版）

```sh
cargo build --release
```

チェック

```sh
cargo check
```

実行

```sh
cargo run
```

実行（非表示）

```sh
cargo run -q
```

ソースコードの成形

```sh
cargo fmt
```

# ライセンス

MIT License

Copyright (c) Kouji Sasaya

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

