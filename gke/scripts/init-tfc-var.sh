#!/bin/bash
rootpath=$(cd "$(dirname "$0")"; pwd -P)
tokenpath=~/.terraformrc
varspath=gke-beta-vars.json
tfcorg=cardinalsolutions
tfcws=gcp-terraform-gke-beta
tfcapibase="https://app.terraform.io/api/v2/organizations/$tfcorg/workspaces/$tfcws"

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

token=$(cat $tokenpath | jq -r '.credentials["app.terraform.io"].token')
workspaceid=$(tfc-api-request $tfcapibase $token | jq -r '.data.id')

cd "$rootpath"
vars=$(jq -r '.vars[] | [.name, .value] | @tsv' $varspath)
while IFS=$'\t' read -r var
do
  name=$(echo $var | awk '{print $1}')
  value=$(echo $var | awk '{print $2}')
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
        "sensitive":false
      },
      "relationships": {
        "workspace": {
          "data": {
            "id":"$workspaceid",
            "type":"workspaces"
          }
        }
      }
    }
  }
EOF
  )
  payload=$(echo $payload | jq -c '.')
  tfc-api-request https://app.terraform.io/api/v2/vars $token $payload
done <<< "$vars"
