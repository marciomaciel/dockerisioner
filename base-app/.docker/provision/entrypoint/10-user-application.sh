#!/usr/bin/env bash
set -Ee
groupadd -g "$APPLICATION_GID" "$APPLICATION_GROUP"
useradd -u "$APPLICATION_UID" --create-home --shell /bin/bash --gid "$APPLICATION_GROUP" "$APPLICATION_USER"
