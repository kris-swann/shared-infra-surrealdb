# Overview

This repo defines infrastructure for a shared SurrealDB instance

It is hosted on fly.io, the primary reasons for this are:
- Simple to setup: Just need to give it a docker image and wire the ports
- Cheap

Backups are sent to Backblaze B2, they are executed by a github action on a cron schedule

## Encryption
Git-crypt is used for encrypting sensitive files

## Setting up
Make sure that you have exported the following before running any terraform commands:
```bash
export B2_APPLICATION_KEY_ID="<secret>"
export B2_APPLICATION_KEY="<secret>"
export FLY_API_TOKEN="<secret>"
export SURREAL_DB_CONN="<secret>"
export SURREAL_DB_USER="<secret>"
export SURREAL_DB_PASS="<secret>"
```

Then you should be able to run the following in the usual way
```bash
terraform init
terraform plan
terraform apply
```

## Validating certificates
You'll have to manually validate the certificates. This should just be a matter of going to the
fly.io app certificates page, and adding CNAME, A, and AAAA records to the DNS.

## How to: Upload to docker hub
We have some slight modifications that we made to the default surrealdb dockerfile, we upload this
file to docker hub so that terraform can use it. Steps to manually push a new tag to the docker hub:

- Log into docker: `docker login`
- Navigate to project root (where `Dockerfile` is)
- Build and tag the Dockerfile: `docker build . --tag krisswann/surrealdb:1.0.0-beta.8-v0`
  - where `1.0.0-beta.8` corresponds to the surrealdb image
  - and `-v0` corresponds to the "version" of the custom dockerfile
- Push to docker hub: `docker push krisswann/surrealdb:1.0.0-beta.8-v0`


## How to: Connect a SurrealDB REPL to the remote db
```bash
surreal sql --conn "$SURREAL_DB_CONN" --user $SURREAL_DB_USER --pass $SURREAL_DB_PASS --pretty
```


## Resources:
- [Launch SurrealDB on Fly.io](https://tutorials.surrealdb.com/community/launch-instance-on-flyio.html)
- [Cronjob options for Fly.io](https://community.fly.io/t/cron-jobs-scheduler-on-fly-io/7791)
- [SurrealDB permissioning example](https://gist.github.com/koakh/fbbc37cde630bedcf57acfd4d6a6956b)
