#!/bin/bash
# configure CircleCI project environment variables

endpoint="https://circleci.com/api/v1"

# Read in from file if argument is specified, otherwise hope stuff is
# in the environment

if [ -f ${1} ] 
then
    . ${1}
fi

curl -s -X POST \
    --header "Content-Type: application/json" \
    -d '{"name":"DEPLOY_CMD", "value":"chef-client -o 'recipe[kwik-e-mart::upload]' -c /var/spool/btb/.chef/client.rb"}' \
    "${endpoint}/project/$username/$project/envvar?circle-token=$token"

curl -s -X POST \
    --header "Content-Type: application/json" \
    -d '{"name":"KNIFE_SSH_PORT", "value":"13892"}' \
    "${endpoint}/project/$username/$project/envvar?circle-token=$token"

curl -s -X POST \
    --header "Content-Type: application/json" \
    -d '{"name":"KNIFE_USER", "value":"btb"}' \
    "${endpoint}/project/$username/$project/envvar?circle-token=$token"

curl -s -X POST \
    --header "Content-Type: application/json" \
    -d '{"name":"KNIFE_WORKSTATION", "value":"0.tcp.ngrok.io"}' \
    "${endpoint}/project/$username/$project/envvar?circle-token=$token"

curl -s -X POST \
    --header "Content-Type: application/json" \
    -d "{\"hostname\":\"0.tcp.ngrok.io\",\"private_key\":\"$(cat ${ssh_key:-${HOME}/.ssh/id_rsa})\"}" \
    "${endpoint}/project/$username/$project/ssh-key?circle-token=$token"
