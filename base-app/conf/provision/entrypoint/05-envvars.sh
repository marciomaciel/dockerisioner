#!/bin/bash
# export application envs
ENV_FILE=/etc/environment
printenv | grep "APPLICATION_.*=" >> "$ENV_FILE"
