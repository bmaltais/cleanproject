#!/bin/bash
nova list --tenant $1 | grep -v '\-+\-' | sed '1d' | awk '{print $2}'
