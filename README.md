# Docker Compose based Databases

This repository contains a single `docker-compose.yml` that has every single
dockerized database or similar service I've used, along with parameters used to
setup the said service.

A new project maybe easily started by chopping services off this file and then
running it with only whatever is necessary.

Since I have 16GB of RAM, I sometimes use this repo to bootstrap projects by
just running shared databases here. Luckily data is namespaced so collections,
databases, indexes, prefixes or whatever a DB chooses to call them don't tend to
conflict.

## Services and Ports

* portainer - 9080
* httpbin - 2080
* minio - 9000
* redis-commander - 6378
* redis - 6379
* postgres - 5432
* pgadmin4 - 5431
* elasticsearch - 9200
* kibana - 5601
* mongodb - 27017
* mongo-express - 7017

## Initial Setup

* Run `sudo ./host-setup.sh` to ensure that the swap is turned off (for stable
  performance) and addressable virtual memory is set to 262144 (to stop
  ElasticSearch from crashing).
* Run `docker-compose pull` to pull in the latest versions of all images defined
  in this docker-compose.yml file.

## Start and Stop Containers

Start containers via `docker-compose up -d`

Check what containers are running via `docker-compose ps`

Check logs of a single container via `docker-compose logs mongo -f`. The `-f`
flag follows new logs as they come. Skip it to not follow and just print the
logs. Omit the container name to get logs of all containers. `docker-compose logs -f`

Stop containers via `docker-compose down`. This preserves your volumes so that
your data is exactly as you left it earlier.

## Tips and Gotchas

### Prune Docker Volumes

Run `docker volume prune` to get rid of all volumes created by docker to give
yourself a fresh start if you screwed up somewhere in the configuration.

### PGAdmin4 Credentials Change

If you changed username/password for default admin on PGAdmin4, you need to
stop all containers and then run `docker volume rm dcdbs_pgadmindata` to remove
the PGAdmin4 volume. Otherwise the updated user/pass from the environment
variables passed through docker-compose.yml doesn't seem to be picked up.
