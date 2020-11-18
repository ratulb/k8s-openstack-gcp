#!/usr/bin/env bash
#Setup kubernetes cluster on openstack deployed on google compute engine
CUREENT=$(pwd)
. create-stack-user.sh
. repo-clone.sh
. gen-conf.sh
cp $CURRENT/dev-tenant-setup.sh /opt/stack/devstack/
chmod +x /opt/stack/devstack/dev-tenant-setup.sh
chown -R stack:stack /opt/stack/
echo "Please cd devstack and run"
echo "./stack.sh"
echo "./dev-tenant-setup.sh"
su - stack

