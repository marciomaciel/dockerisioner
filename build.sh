#!/bin/bash
set -Euex
docker rm -f magento-test
docker build -t dockerisioner/base:latest base/
docker build -t dockerisioner/base-app:latest base-app/
docker build -t magento-test app-test/
docker run -d --name magento-test magento-test
docker logs -f magento-test

