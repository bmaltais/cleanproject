#!/bin/bash
# Take tenantid as an argument

neutron router-list --tenant-id $1 -f csv | sed '1d' | awk -F "\"" '{print $2}'
