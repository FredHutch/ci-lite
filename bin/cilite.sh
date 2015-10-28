#!/bin/bash
set -e
set -x
#
# cilite.sh <source> <ref>
#
# Script to checkout and deploy chef policy to server
src=$1
ref=$( echo $2 | cut -d/ -f 3 )

spooldir='/var/spool/cilite'
# GIT_DIR is set to "." in the post-receive world
export GIT_WORK_TREE=${spooldir}/policy-repo
export GIT_DIR="${GIT_WORK_TREE}/.git"

if [ \! -w $spooldir ]
then
    echo "ERROR: no write permissions in working directory $spooldir" >&2
    exit 1
fi

cd $spooldir

# clone repository if it doesn't exist
if [ \! -d policy-repo ]
then
    echo "CILITE: cloning repo from $src"
    git clone $src policy-repo
    git checkout --quiet $ref
else
    echo "CILITE: updating cilite repository"
    git pull  --quiet
    git checkout --quiet $ref
fi

echo "CILITE: uploading to chef server"

cd policy-repo
knife upload .

