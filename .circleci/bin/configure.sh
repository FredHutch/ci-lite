#!/bin/bash -x
# configure CircleCI project environment variables

# DEPLOY_CMD: chef-client -o 'recipe[kwik-e-mart::upload]' -c /var/spool/btb/.chef/client.rb
# KNIFE_SSH_PORT
# KNIFE_USER
# KNIFE_WORKSTATION

endpoint="https://circleci.com/api/v1"
username=FredHutch

curl https://circleci.com/api/v1/me?circle-token=${token}

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
    -d "{\"hostname\":\"0.tcp.ngrok.io\",\"private_key\":\"$(cat $ssh_key)\"}" \
    "${endpoint}/project/$username/$project/ssh-key?circle-token=$token"