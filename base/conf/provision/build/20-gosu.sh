#!/bin/bash
set -o pipefail -Ee
wget -O "/sbin/gosu" "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64"
wget -O "/tmp/gosu.asc" "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64.asc"
GNUPGHOME="$(mktemp -d)"
export GNUPGHOME
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
gpg --batch --verify /tmp/gosu.asc "/sbin/gosu"
rm -rf "$GNUPGHOME" /tmp/gosu.asc
chmod +x "sbin/gosu"
/sbin/gosu nobody true
