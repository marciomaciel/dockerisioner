#!/usr/bin/env bash
set -Euex
VERSION=debian-buster
docker rm -f test
#docker build -t dockerisioner/base:"$VERSION" base/
#docker push dockerisioner/base:"$VERSION"
#docker build -t dockerisioner/base-app:"$VERSION" base-app/
#docker push dockerisioner/base-app:"$VERSION"
docker build -t dockerisioner/php:7.4 php/7.4/
docker push dockerisioner/php:7.4
docker build -t dockerisioner/php-nginx:7.4 php-nginx/7.4/
docker push dockerisioner/php-nginx:7.4
#docker build -t test app-test/
#docker run -d --name test -p 80:80 -p 443:443 -e PHP_MEMORY_LIMIT=2G -e PHP_DISPLAY_ERRORS=On -e PHP_MAX_EXECUTION_TIME=300 test
#docker logs -f test

