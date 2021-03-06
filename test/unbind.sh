#!/bin/bash -e

INSTANCE_ID="$1"
BINDING_ID="$2"
PLAN_UUID="$3"

if [ -z "$4" ]
then
      HOSTNAME='172.17.0.1'
else
      HOSTNAME=$4
fi

validate_param() {
  if [ "$1" = "" ]
  then
    echo "Usage: $0 <instance uuid> <binding uuid> <plan uuid>"
    exit
  fi
}

validate_param "$INSTANCE_ID"
validate_param "$BINDING_ID"
validate_param "$PLAN_UUID"


req="{
  \"plan_id\": \"$PLAN_UUID\",
  \"service_id\": \"$SERVICE_UUID\",
  \"context\": \"blog-project\",
  \"app_guid\":\"\",
  \"bind_resource\":{},
  \"parameters\": {}
}"

curl \
    -k \
    -X DELETE \
    -H "Authorization: bearer $(oc whoami -t)" \
    -H "Content-type: application/json" \
    -H "Accept: application/json" \
    -H "X-Broker-API-Originating-Identity: " \
    "https://broker-automation-broker.$HOSTNAME.nip.io/automation-broker/v2/service_instances/$INSTANCE_ID/service_bindings/$BINDING_ID?accepts_incomplete=true&plan_id=$PLAN_UUID"
