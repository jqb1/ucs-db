#!/bin/bash

[[ "${EUID}" -ne "0" ]] \
  && { echo 'Root permisions required.' 1>&2; exit 1; }

# Make sure you've got docker entry in your apt.
# Install docker engine afterwards.
apt-get update
apt-get install -y docker.io

# It's weird, but docker daemon starts up right away,
# so just in case, re-start it.
service docker restart

# These names does not matter.
PERSISTANCE_STORAGE='database'
INTERNAL_NETWORK='lorehaven'

MYSQL='database'
MYSQL_ROOT_PASSWORD='bazdan#20'

# These ports does matter.
MYSQL_OUTER_PORT='3306'
FLASK_OUTER_PORT='80'

# Do the docker magic.

docker volume create "${PERSISTANCE_STORAGE}"
docker network create "${INTERNAL_NETWORK}"

docker run \
-e MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}" \
-v "${PERSISTANCE_STORAGE}":/var/lib/mysql \
--network="${INTERNAL_NETWORK}" \
--name="${MYSQL}" \
-p "${MYSQL_OUTER_PORT}":3306 \
-d \
mysql:5.7

docker run \
-e USER='root' \
-e PASSWORD="${MYSQL_ROOT_PASSWORD}" \
-e HOST="${MYSQL}" \
-v "${PWD}/mysql":/sql \
--network="${INTERNAL_NETWORK}" \
-d \
theredfoxlee/mysql-exec:1.0

docker run \
-v "${PWD}/flask":/app \
--network="${INTERNAL_NETWORK}" \
-p "${FLASK_OUTER_PORT}":80 \
-d \
theredfoxlee/flask:1.0

