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

There's Makefile included that you can refer to if you can't remember
docker-compose commands!

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

### MongoDB Connection Setup

You should first login to [127.0.0.1:7017](127.0.0.1:7017) to open mongo-express
and create a new database for a project you are starting.

The URI for MongoDB under this docker-compose.yml should look something like
this:

```
mongodb://mongo:mongo@127.0.0.1:27017/projectname?connectTimeoutMS=3000&authSource=admin"

```

Note the additional `authSource=admin` most docs seem to leave out. This tells
MongoDB that you want the user `mongo` to be authenticated against the `admin`
database (that is created by default and has declared users inside).

## Desktop Admin Interfaces

Usually you'd want to run without admin GUIs within the Docker image, so that
you can use ONE desktop admin GUI per database but use this to manage multiple
instances of one database. I'm listing names of admin GUIs I've found to be
nice. Except for RedisInsight, all others are auto-installed if you use
[Rhino flavoured Ubuntu](https://github.com/wingedrhino/DistroSetup/tree/trunk/setup-helpers/Ubuntu).

### PostgreSQL - PgAdmin 4

The desktop app is just a system tray icon that launches the server on localhost
and lets you open it on a browser. But it works!

### Redis - RedisInsight

This isn't opensource but it's free use, by RedisLabs. Get it
[here](https://redislabs.com/redisinsight/). You need to jump through a few
hoops to get it though. So if Commander works just fine, don't bother!

### General Purpose SQL - DBeaver

I usually keep this around *just* to help me visualize someone else's database
schema quickly. It creates a useful ER diagram of all tables and works with
PostgreSQL, MySQL, MariaDB and SQLite3.

### MongoDB - Compass

It's the official GUI by MongoDB, Inc. Released under SSPL, it's free to use as
a standalone management tool. I recommend the Compass Isolated edition, since it
has all the features of Compass but doesn't dial back home.

Check out the versions [here](https://docs.mongodb.com/compass/master/), the
source code [here](https://github.com/mongodb-js/compass/) and finally, the
download page is [here](https://www.mongodb.com/download-center/compass).

### MySQL - MySQL Workbench

Probably the ONE reason (alongside sharding & clustering support from way back)
MySQL has way more users than PostgreSQL. I never used MySQL personally, but
this is the app I've seen open on every MySQL user's desktop since forever!

Download it [here](https://dev.mysql.com/downloads/workbench/).

