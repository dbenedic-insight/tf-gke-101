#!/bin/bash

endpoint=$1
orgname=$2
workspacename=$3
token=$4

tfeapibase="$endpoint/api/v2/organizations/$orgname/workspaces/$workspacename"

function tfc-api-request() {
  endpoint=$1
  token=$2
  payload=$3

  if [[ -z "$payload" ]]; then
    request=GET
    data="null"
  else
    request=POST
    data=$payload
  fi
  curl \
  --header "Authorization: Bearer $token" \
  --header "Content-Type: application/vnd.api+json" \
  --request $request \
  --data $data \
  $endpoint
}

workspaceid=$(tfc-api-request $tfeapibase $token | jq -r '.data.id')
tfeapiworkspace="$endpoint/api/v2/workspaces/$workspaceid"
vars=$(env | grep 'TF_VAR_')
while IFS=$'\t' read -r var
do
  name=$(echo $var | awk -F= '{print $1}' | sed 's/TF_VAR_//')
  value=$(echo $var | awk -F= '{print $2}')
  payload=$(cat <<- EOF
  {
    "data": {
      "type":"vars",
      "attributes": {
        "key":"$name",
        "value":"$value",
        "description":"",
        "category":"terraform",
        "hcl":false,
        "sensitive":"false"
      }
    }
  }
EOF
  )
  payload=$(echo $payload | jq -c '.')
  tfc-api-request "$tfeapiworkspace/vars" $token $payload
done <<< "$vars"
