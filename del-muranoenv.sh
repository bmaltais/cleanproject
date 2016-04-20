#!/bin/bash
# Take tenantid as an argument

dirname=`dirname $0`

for j in $( $dirname/get-muranoenv.sh $1 ); do
  echo Deleting murano env id $j
  murano --os-username $1-a --os-password $1-a --os-tenant-name $1 environment-delete $j
done

WAITING=`$dirname/get-muranoenv.sh $1`
while ! [ -z $WAITING ]; do
  echo "Waiting for Murano environment(s) to be deleted"
  sleep 5
  WAITING=`$dirname/get-muranoenv.sh $1`
done

