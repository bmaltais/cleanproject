#!/bin/bash
# Take tenantid as an argument

dirname=`dirname $0`

  for i in $( neutron port-list --tenant-id $1 | grep 'subnet_id' | awk '{print $2}' ); do
    echo $i
  done

