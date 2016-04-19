#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    exit
fi

############## Define those variables for the tenant (this is just an example)
TENANT=$1
PASSWORD=$1
TENANT_DESC="$1"
TENANT_EMAIL="project@lab.com"
TENANT_NET_CIDR="$2"
#TENANT_NET_CIDR="10.0.0.0/24"
#TENANT_NET_GW="10.0.0.1"
############### 

# Create a new project and get the id
openstack project create $TENANT --description $TENANT_DESC 
TENANT_ID=$(openstack project list | awk "/\ $TENANT\ / { print \$2 }")

# Create a new user 
openstack user create --project $TENANT --password $PASSWORD --email $TENANT_EMAIL $TENANT

# Create the network with VXLAN
neutron net-create --tenant-id $TENANT_ID --provider:network_type vxlan "$TENANT-net"

# Create the subnet and get the ID
#neutron subnet-create --name "$TENANT-subnet" --tenant-id $TENANT_ID --gateway $TENANT_NET_GW "$TENANT-net" $TENANT_NET_CIDR --dns-nameserver 8.8.8.8 --dns-nameserver 8.8.4.4
neutron subnet-create --name "$TENANT-subnet" --tenant-id $TENANT_ID "$TENANT-net" $TENANT_NET_CIDR --dns-nameserver 8.8.8.8 --dns-nameserver 8.8.4.4
TENANT_SUBNET_ID=$(neutron subnet-list -f csv -F id -F cidr | grep "$TENANT_NET_CIDR" | cut -f1 -d',' | tr -d '"')
  
# Create an HA Router and get the ID
neutron router-create --tenant-id $TENANT_ID "$TENANT-net-to-public"
ROUTER_ID=$(neutron router-list  -f csv -F id -F name | grep "$TENANT-net-to-public" | cut -f1 -d',' | tr -d '"')
 
# Set the gw for the new router
neutron router-gateway-set "$TENANT-net-to-public" public_floating_net
   
# Add a new interface in the main router
neutron router-interface-add $ROUTER_ID $TENANT_SUBNET_ID
