#!/bin/bash
# Take tenant name as an argument
read -p "Are you sure you want to delete project $1? There is no way back [Y or N]: " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuffa
    dirname=`dirname $0`
    tenant=`$dirname/get-tenantid.sh $1`
    $dirname/create-temp-user.sh $1
    $dirname/del-muranoenv.sh $1
    $dirname/del-temp-user.sh $1
    $dirname/del-vm.sh $tenant
    # $dirname/del-ports.sh $tenant
    $dirname/del-router.sh $tenant
    $dirname/del-net.sh $tenant
    # openstack project delete $1
    # openstack user delete $1
fi
