#!/bin/bash
# Take tenantid as an argument

dirname=`dirname $0`

for j in $( $dirname/get-router-list.sh $1 ); do

  echo Deleting gateway of router id $j

  neutron router-gateway-clear $j

  for i in $( neutron router-port-list $j | grep 'subnet_id' | awk '{print $8}' | awk -F "\"" '{print $2}' ); do
    echo Deleting router id $j interface id $i
    neutron router-interface-delete $j $i
  done

  echo Deleting router id $j
  neutron router-delete $j
done

