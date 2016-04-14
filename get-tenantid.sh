#!/bin/bash
openstack project list | awk "/\ $1\ / { print \$2 }"
#keystone tenant-list | grep $1 | awk '{print $2}'
