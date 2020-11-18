#!/usr/bin/env bash
IP_ADDRESS=$(ip addr | grep ens4 -A 1 | grep inet | awk '{print $2}')
EXTRACTED_IP_ADDR=$(echo $IP_ADDRESS | cut -d'/' -f 1)
echo "IP address of compute engine is : $EXTRACTED_IP_ADDR"
#Local configuration - override as needed
cat <<EOF | tee  /opt/stack/devstack/local.conf
[[local|localrc]]
ADMIN_PASSWORD=secret
DATABASE_PASSWORD=\$ADMIN_PASSWORD
RABBIT_PASSWORD=\$ADMIN_PASSWORD
SERVICE_PASSWORD=\$ADMIN_PASSWORD
HOST_IP=${EXTRACTED_IP_ADDR}
RECLONE=yes
LOGFILE=/opt/stack/logs/stack.sh.log
VERBOSE=True
LOG_COLOR=False
SCREEN_LOGDIR=/opt/stack/logs
EOF
