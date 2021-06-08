#!/usr/bin/env bash
set -Euex

docker rm -f magento-base

docker build -t evinobr/magento-base:v2.4 magento-base/
docker push evinobr/magento-base:v2.4
#docker run -d --name magento-base -p 80:80 -p 443:443 -e PHP_MEMORY_LIMIT=2G -e PHP_DISPLAY_ERRORS=On -e FPM_DISABLE_ACCESS_LOG=1 -e FPM_LOG_LEVEL=warning -e PHP_MAX_EXECUTION_TIME=300 evinobr/magento-base:v1
#docker logs -f magento-base

