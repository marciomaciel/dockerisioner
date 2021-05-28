#!/usr/bin/env bash
# supervisor entrypoint (default)
set -o pipefail
set -Ee
exec /opt/docker/bin/service.d/supervisor.sh
