#!/bin/bash
set -e

COMMIT_HASH="f9f0988e8518d8fcadf4d59e1b8b923dd948d3da"

rm -rf generated
mkdir generated
cat >generated/deltatouch-git.json <<EOL
[
    {
        "type": "git",
        "url": "https://codeberg.org/lk108/deltatouch.git",
        "commit": "${COMMIT_HASH}"
    }
]
EOL

rm -rf deltatouch-shallow
git clone --depth 1 --no-checkout https://codeberg.org/lk108/deltatouch deltatouch-shallow
(cd deltatouch-shallow && git fetch --depth 1 origin "${COMMIT_HASH}" && git checkout "${COMMIT_HASH}" && git submodule update --init --recursive --depth 1)

uvx --from flatpak_cargo_generator flatpak-cargo-generator deltatouch-shallow/libs/chatmail-core/Cargo.lock -o generated/sources-rust.json
