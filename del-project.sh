#!/bin/bash
# Take tenant name as an argument

dirname=`dirname $0`
tenant=`$dirname/get-tenantid.sh $1`

$dirname/del-vm.sh $tenant
$dirname/del-router.sh $tenant
$dirname/del-net.sh $tenant
