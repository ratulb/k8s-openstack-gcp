#!/usr/bin/env bash
#Setup kubernetes cluster on openstack deployed on google compute engine
RED='\033[0;31m'

. create-stack-user.sh
. repo-clone.sh
. gen-conf.sh
cp $CURRENT/dev-tenant-setup.sh /opt/stack/devstack/
chmod +x /opt/stack/devstack/dev-tenant-setup.sh
chown -R stack:stack /opt/stack/
printf "${RED}Please run the following\n"
printf "${RED}cd devstack\n"
printf  "${RED}./stack.sh\n"
printf "${RED}./dev-tenant-setup.sh\n"
su - stack

