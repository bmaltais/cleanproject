#!/bin/bash
dirname=`dirname $0`

for j in $( $dirname/get-net-list.sh $1 ); do

  echo Deleting netowrk id $j
  neutron net-delete $j
done

