#!/bin/bash

[[ "${EUID}" -ne "0" ]] \
  && { echo 'Root permisions required.' 1>&2; exit 1; }

apt-get install -y docker.io
apt-get install -y docker-compose

service docker restart

docker compose-up up -d

docker run --priviliged=true -v ./mysql:/sql -d theredfoxlee/mysql-client:1.0 \
  sh -c "mysql -uroot -pbazdan#20 < /sql/init-db.sql"

