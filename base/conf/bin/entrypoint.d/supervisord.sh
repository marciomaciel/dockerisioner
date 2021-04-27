#!/bin/bash
# supervisor entrypoint (default)
set -o pipefail -Ee
exec /opt/docker/bin/service.d/supervisor.sh
