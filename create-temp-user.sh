#!/bin/bash
# Take tenantid as an argument
openstack user create --project $1 --password $1-a --email t@t.com $1-a
echo Waiting for temp user creation
sleep 5
