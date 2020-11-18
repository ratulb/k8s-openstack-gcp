#!/usr/bin/env bash

source openrc admin admin
 
openstack project delete dev-project
openstack project create --description 'Development project' dev-project --domain default
 
openstack user delete dev
openstack user create --project dev-project --password secret dev
openstack role add --user dev --project dev-project member

source openrc dev dev-project

#Image image management
wget --timestamping https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img
#We are tweaking the image to set the password
#apt install libguestfs-tools -y
#virt-customize -a bionic-server-cloudimg-amd64.img --root-password password:secret

openstack image delete ubuntu-18.04-image
openstack image create --disk-format qcow2 --container-format bare --file bionic-server-cloudimg-amd64.img ubuntu-18.04-image
 
#SSH key pair management 
openstack keypair delete dev-key-pair
openstack keypair create dev-key-pair > dev-key-pair.pem
chmod 0600 dev-key-pair.pem

#Security group management
openstack security group delete dev-security-group
openstack security group create --description "Permissive security group" dev-security-group
openstack security group rule create dev-security-group --protocol tcp --dst-port 22:22 --remote-ip 0.0.0.0/0
openstack security group rule create --protocol icmp dev-security-group 

#Network management
openstack network delete dev-network
openstack network create dev-network
openstack subnet create dev-subnet --subnet-range 192.168.0.0/24 --dns-nameserver 8.8.8.8 --network dev-network
#Settle down 
sleep 5
#Router management
openstack router delete dev-router
openstack router create dev-router
openstack router add subnet dev-router dev-subnet
openstack router set --external-gateway public dev-router 

#Settle down 
sleep 5

#Server management
openstack network list 
NETWORK_ID=$(openstack network list | grep dev-network | awk '{print $2}')
openstack server delete master
openstack server create --flavor m1.small --image ubuntu-18.04-image --nic net-id=$NETWORK_ID \
  --security-group dev-security-group --key-name dev-key-pair master
                                             
#openstack console url show
#Settle down 
sleep 5
openstack server delete worker
openstack server create --flavor m1.small --image ubuntu-18.04-image --nic net-id=$NETWORK_ID \
  --security-group dev-security-group --key-name dev-key-pair worker

#Settle down 
sleep 5
#Floating IP assignment
openstack floating ip create public
FLOATING_IP=$(openstack floating ip list | grep None | awk '{print $4}')
openstack server add floating ip master $FLOATING_IP
#Settle down 
sleep 5
openstack floating ip create public
FLOATING_IP=$(openstack floating ip list | grep None | awk '{print $4}')
openstack server add floating ip worker $FLOATING_IP
echo "Done setting up - pleas check."
