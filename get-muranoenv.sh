#!/bin/bash
# Take tenantid as an argument
murano --os-username $1-a --os-password $1-a --os-tenant-name $1 environment-list | grep -v '\-+\-' | sed '1d' | awk '{print $2}'
