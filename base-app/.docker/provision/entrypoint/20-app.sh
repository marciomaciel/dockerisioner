#!/usr/bin/env bash
set -o pipefail -Ee
mkdir -p "$APPLICATION_PATH"
chown "$APPLICATION_USER":"$APPLICATION_GROUP" "$APPLICATION_PATH"
