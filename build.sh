#!/bin/bash
docker rm -f base
docker build -t dockerisioner/base:latest base/
docker run -d --name base dockerisioner/base:latest
sleep 5
docker logs base

