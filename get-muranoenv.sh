#!/bin/bash
# Take tenantid as an argument
openstack user create --project $1 --password $1-a --email t@t.com $1-a
echo Waiting for temp user creation
sleep 5
murano --os-username $1-a --os-password $1-a --os-tenant-name $1 environment-list | grep -v '\-+\-' | sed '1d' | awk '{print $2}'
