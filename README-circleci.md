# CI-Lite

This branch contains helpers and configuration files for
deploying and testing via CircleCI.

This method uses ssh to a knife workstation with access to the Chef and Supermarket server

# Installing

Install from releases created by generating a tag on this branch. Until this repository goes public, its necessary to use the API and your credentials and/or tokens to download.

A command of the form:

```
curl -L \
--header 'Authorization: token <access token>' \
https://api.github.com/repos/FredHutch/ci-lite/tarball/1.0.7 |\
tar --strip-components=1 -xzvf -
```

will then extract `circle.yml` and `.circleci` into the current directory- use
the root of your cookbook to put these files in the correct location.  These
can be checked into your repository, but be sure to refresh on occasion.

# Configuration

Configuration requires adding a few environment variables and a key to the
circle ci build project.  The script `.circleci/bin/configure.sh` will set
these environment variables.  The script is run in this manner:

```
variable=value [...] ./configure.sh
```

you may pass in the path to a file with those variables configured as an
argument to the script:

```
./configure /path/to/variables.sh
```

or combine them as:

```
variable=value [...] ./configure /path/to/variables.sh
```

## Variables

These variables are used to connect to circle CI

- `username`: the username for the CircleCI project
- `project`: the project name in CircleCI
- `token`: an API access token

These are used to configure Circle CI with the environment variables necessary
to run the deploy.  These will be written into the project's environment
variables.

- `ssh_key_file`: path to a file with a private key for knife workstation access
- `KNIFE_WORKSTATION`: hostname of workstation with access
- `KNIFE_SSH_PORT`: port that SSH listens on
- `KNIFE_USER`: username to use for access- must be able to upload cookbooks
- `DEPLOY_CMD`: command used to initiate the deploy on the knife workstation

## Variable template

```
ssh_key=/path/to/id_rsa
username=FredHutch
project=scicomp-roles
token=<api token from your account>
KNIFE_WORKSTATION=<hostname to shell into>
KNIFE_SSH_PORT=<tcp port that ssh listens on>
KNIFE_USER=<username of user on knife workstation>
```
