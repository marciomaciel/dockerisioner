#!/bin/bash
set -Euex
docker rm -f nginx-test
docker build -t dockerisioner/base:latest base/
docker build -t dockerisioner/base-app:latest base-app/
docker build -t dockerisioner/php:7.4-latest php/7.4/
docker build -t dockerisioner/php-nginx:7.4-latest php-nginx/7.4/
docker run -d --name nginx-test -p 80:80 -p 443:443 dockerisioner/php-nginx:7.4-latest
docker logs -f nginx-test

