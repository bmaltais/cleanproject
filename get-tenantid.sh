#!/bin/bash
# Take the tenant name as an argument

openstack project list | awk "/\ $1\ / { print \$2 }"
