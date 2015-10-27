# CI-Lite

> Lightweight CI for Chef using the R10K "push and go" model

Implements a workflow inspired by r10k where pushing to a branch causes an update of the Chef policy repository using git server-side hooks.

On a push to the production branch, the hooks perform the following actions:

1. Pre-receive:
    > 1. if changed, check environment cookbook version in chef server
    >    to ensure version is incremented
    > 1. if changed, check roles cookbook version in chef server
    >    to ensure version is incremented

1. Post-recieve:
    > 1. if ref is a branch named production, push upstream to github
    > 1. if the ref is a tag, push tags upstream 
    > 1. deploy policy repo to chef server (TBD)

