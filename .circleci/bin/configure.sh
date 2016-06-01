#!/bin/bash -x
# configure CircleCI project environment variables

endpoint="https://circleci.com/api/v1"

# Read in from file if argument is specified, otherwise hope stuff is
# in the environment

if [ -f ${1} ] 
then
    . ${1}
fi

export DEPLOY_CMD
payload=$(echo '{"name":"DEPLOY_CMD", "value":"$DEPLOY_CMD"}' | envsubst )
curl -s -X POST \
    --header "Content-Type: application/json" \
    -d "${payload}" \
    "${endpoint}/project/$username/$project/envvar?circle-token=$token"

export KNIFE_SSH_PORT
payload=\
    $(echo '{"name":"KNIFE_SSH_PORT", "value":"$KNIFE_SSH_PORT"}' |envsubst )
curl -s -X POST \
    --header "Content-Type: application/json" \
    -d "${payload}" \
    "${endpoint}/project/$username/$project/envvar?circle-token=$token"

export KNIFE_USER
payload=$(echo '{"name":"KNIFE_USER", "value":"$KNIFE_USER"}' |envsubst)
curl -s -X POST \
    --header "Content-Type: application/json" \
    -d "${payload}" \
    "${endpoint}/project/$username/$project/envvar?circle-token=$token"

export KNIFE_WORKSTATION
payload=\
    $(echo '{"name":"KNIFE_WORKSTATION", "value":"$KNIFE_WORKSTATION"}' |envsubst)
curl -s -X POST \
    --header "Content-Type: application/json" \
    -d "${payload}" \
    "${endpoint}/project/$username/$project/envvar?circle-token=$token"

ssh_key=$(cat ${ssh_key_file:-${HOME}/.ssh/id_rsa})
export ssh_key
payload=$(\
    echo '{"hostname":"$KNIFE_WORKSTATION","private_key":"${ssh_key}"}' \
    |envsubst \
    )
curl -s -X POST \
    --header "Content-Type: application/json" \
    -d "${payload}" \
    "${endpoint}/project/$username/$project/ssh-key?circle-token=$token"

