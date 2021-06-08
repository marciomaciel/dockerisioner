#!/usr/bin/env bash
# prepare entrypoint
set -Ee
chmod +x /opt/docker/bin/entrypoint.sh
ln -sf /opt/docker/bin/entrypoint.sh /entrypoint
ln -sf /opt/docker/bin/entrypoint.d /entrypoint.d
mkdir -p /entrypoint.d
chmod 700 /entrypoint.d
chown root:root /entrypoint.d
