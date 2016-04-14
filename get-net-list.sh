#!/bin/bash
# Take tenantid as an argument

neutron net-list --tenant-id $1 -f csv | sed '1d' | awk -F "\"" '{print $2}'
