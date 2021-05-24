#!/bin/bash
set -o pipefail -Ee
chmod 1777 /tmp
if [ -d /opt/docker/bin/ ]; then
    find /opt/docker/bin/ -type f -iname '*.sh' -print0 | xargs --no-run-if-empty -0 chmod +x
fi
