#!/bin/bash
set -e

COMMIT_HASH="d2ec83dcecebc91049755da6717e926563809e55"

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
git clone --depth 1 --recurse-submodules --shallow-submodules https://codeberg.org/lk108/deltatouch deltatouch-shallow

uvx --from flatpak_cargo_generator flatpak-cargo-generator deltatouch-shallow/libs/chatmail-core/Cargo.lock -o generated/sources-rust.json
