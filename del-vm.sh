#!/bin/bash
dirname=`dirname $0`

for j in $( $dirname/get-vm-list.sh $1 ); do

  echo Deleting vm id $j
  nova delete $j
done

