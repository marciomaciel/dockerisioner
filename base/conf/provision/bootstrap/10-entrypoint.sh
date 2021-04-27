#!/bin/bash
# prepare entrypoint
set -o pipefail -Ee
ln -sf /opt/docker/bin/entrypoint.sh /entrypoint
ln -sf /opt/docker/bin/entrypoint.d /entrypoint.d
mkdir -p /entrypoint.d
chmod 700 /entrypoint.d
chown root:root /entrypoint.d
