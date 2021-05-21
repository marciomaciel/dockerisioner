#!/bin/bash
# fix tmp permissions
set -o pipefail
set -Ee
chmod 1777 /tmp
