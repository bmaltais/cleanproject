# cleanproject
Tools to delete all project/tenant resources in OpenStack. I tried to use ospurge with my Mirantis 8 deployment but it would not work properly... so I decided to write my own in highly modular bash script ;-) OK, this is old school but since it is broken is small peices it is easy to maintain when something is broken and individeal scripts can be used when needed.

So use it if you like.

Basic usage
-----------

The following command will delete all VMs, routers and networks aoosciated to the project from Openstack:

./del-project.sh "project name"

