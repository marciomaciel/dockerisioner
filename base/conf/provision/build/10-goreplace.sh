#!/bin/bash
set -Ee
SCRIPT_DESTINATION="/usr/local/bin/go-replace"
wget -O "$SCRIPT_DESTINATION" "https://github.com/webdevops/goreplace/releases/download/1.1.2/gr-64-linux"
chmod +x "$SCRIPT_DESTINATION"
"$SCRIPT_DESTINATION" --version
