#!/usr/bin/env bash
CURRENT=$(pwd)
if [ ! -d /opt/stack/devstack/ ]; then
  printf "Cloning devstack repository...\n"
  git clone https://github.com/openstack-dev/devstack.git /opt/stack/devstack/ --depth 1
else
  cd /opt/stack/devstack/
  printf "Pulling devstack...\n"
  git pull
fi
chown -R stack:stack /opt/stack/devstack/
cd $CURRENT
