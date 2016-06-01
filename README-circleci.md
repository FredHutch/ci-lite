# CI-Lite

This branch contains helpers and configuration files for
deploying and testing via CircleCI.

This method uses ssh to a knife workstation with access to the Chef and Supermarket server

Environment Variables

Install these using Circle CI's "Environment Variables"

- `KNIFE_WORKSTATION`: hostname of workstation with access
- `KNIFE_SSH_PORT`: port that SSH listens on
- `KNIFE_USER`: username to use for access- must be able to upload cookbooks
- `CHEF_SERVER_URL`: URL for access to the Chef server
- `SUPERMARKET_URL`: 

