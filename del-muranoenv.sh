#!/bin/bash
# Take tenantid as an argument

dirname=`dirname $0`

for j in $( $dirname/get-muranoenv.sh $1 ); do
  echo Deleting murano env id $j
  murano --os-username $1-a --os-password $1-a --os-tenant-name $1 environment-delete --abandon $j
done
openstack user delete $1-a


