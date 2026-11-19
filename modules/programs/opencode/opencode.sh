#!/bin/sh

oct() {
    tmp_dir=$(mktemp --directory)
    prev_dir=$(pwd)
    cd "$tmp_dir"
    opencode $@
    cd "$prev_dir"

    if ! rmdir "$tmp_dir" 1>/dev/null 2>&1; then
        echo "Temporary directory not empty"
    fi
}
