#!/usr/bin/env bash
set -o pipefail -Ee
if [[ ! -e "$WEB_DOCUMENT_ROOT" ]]; then
    echo "[WARNING] WEB_DOCUMENT_ROOT does not exists with path \"$WEB_DOCUMENT_ROOT\"!"
fi
