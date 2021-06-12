#!/usr/bin/env bash
set -Euex
VERSION=debian-buster
docker build -t dockerisioner/base:"$VERSION" --no-cache base/
docker push dockerisioner/base:"$VERSION"
docker build -t dockerisioner/base-app:"$VERSION" --no-cache base-app/
docker push dockerisioner/base-app:"$VERSION"
docker build -t dockerisioner/php:7.4 --no-cache php/7.4/
docker push dockerisioner/php:7.4
docker build -t dockerisioner/php-nginx:7.4 --no-cache php-nginx/7.4/
docker build -t dockerisioner/php-nginx:7.4 --no-cache php-nginx/7.4/
docker push dockerisioner/php-nginx:7.4
docker build -t evinobr/magento-base:v2.4 --no-cache magento-base/
docker push evinobr/magento-base:v2.4
