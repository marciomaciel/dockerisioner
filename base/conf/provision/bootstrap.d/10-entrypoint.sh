#!/bin/bash
ln -sf /opt/docker/bin/entrypoint.sh /entrypoint
ln -sf /opt/docker/bin/entrypoint.d /entrypoint.cmd
mkdir -p /entrypoint.d
chmod 700 /entrypoint.d
chown root:root /entrypoint.d
