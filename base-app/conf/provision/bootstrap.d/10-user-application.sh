#!/usr/bin/env bash
groupadd -g "$APPLICATION_GID" "$APPLICATION_GROUP"
useradd -u "$APPLICATION_UID" --home "/home/application" --create-home --shell /bin/bash --no-user-group "$APPLICATION_USER"
usermod -g "$APPLICATION_GROUP" "$APPLICATION_USER"
