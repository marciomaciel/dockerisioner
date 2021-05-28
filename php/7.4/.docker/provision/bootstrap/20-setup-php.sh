#!/usr/bin/env bash
set -o pipefail -Ee
PHP_ETC_DIR=/usr/local/etc/php
ln -sf "/opt/docker/etc/php/php.default.ini" "${PHP_ETC_DIR}/conf.d/98-default.ini"
ln -sf "/opt/docker/etc/php/php.ini" "${PHP_ETC_DIR}/conf.d/99-docker.ini"
