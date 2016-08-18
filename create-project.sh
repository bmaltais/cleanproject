#!/bin/bash
# Take tenantid as an argument

OS_TOKEN=`curl -i \
  -H "Content-Type: application/json" \
  -d '
{ "auth": {
    "identity": {
      "methods": ["password"],
      "password": {
        "user": {
          "name": "'$OS_USERNAME'",
          "domain": { "name": "mgmt" },
          "password": "'$OS_PASSWORD'"
        }
      }
    },
    "scope": {
      "project": {
        "name": "'OS_PROJECT_NAME'",
        "domain": { "name": "mgmt" }
      }
    }
  }
}' \
https://openlab.ssclab.com:5000/v3/auth/tokens | awk '/X-Subject-Token/ {print $2}'| tr -d '\r'`

curl -sX POST -H "X-Auth-Token:$OS_TOKEN" -H "Content-Type: application/json" -d "{\"project\": {\"name\": \"$1\", \"enabled\": true, \"domain_id\": \"bf7a20b90de94390a2ea551b0fd51ecc\", \"description\": \"\"}}" https://openlab.ssclab.com:5000/v3/projects |jq '.'
