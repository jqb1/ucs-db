#!/bin/bash

[[ "${EUID}" -ne "0" ]] \
  && { echo 'Root permisions required.' 1>&2; exit 1; }

cat  << 'END' > /etc/yum.repos.d/centos.repo
[CentOS-extras]
name=CentOS-7-Extras
mirrorlist=http://mirrorlist.centos.org/?release=7&arch=$basearch&repo=extras&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
END

yum update -y
yum install docker -y

systemctl start docker

MYSQL_ROOT_PASSWORD='bazdan1'
MYSQL_DATABASE='used_cars_store'
MYSQL_USER='captain_mysql'
MYSQL_PASSWORD='admin1'

MYSQL_SHARED_VOLUME='mysql_db'
MYSQL_PORT='3306'

FLASK_HOST='0.0.0.0'
FLASK_PORT='80'

MYSQL_SERVER='mysql'
FLASK_APP='gate'

docker volume create "${MYSQL_SHARED_VOLUME}"

docker run \
  -e MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}" \
  -e MYSQL_DATABASE="${MYSQL_DATABASE}" \
  -e MYSQL_USER="${MYSQL_USER}" \
  -e MYSQL_PASSWORD="${MYSQL_PASSWORD}" \
  -v "${MYSQL_SHARED_VOLUME}":/var/lib/mysql \
  -p "${MYSQL_PORT}":3306 \
  -d \
  --name "${MYSQL_SERVER}" \
  mysql:8.0.11

docker run \
  -e "source /sql/create_db.sql" \
  -e "source /sql/init_db.sql" \
  -v "${PWD}/sql":/sql \
  --link "${MYSQL_SERVER}":mysql \
  -it arey/mysql-client \
  -h mysql -p"${MYSQL_ROOT_PASSWORD}"

docker run \
  -e HOST="${FLASK_HOST}" \
  -e PORT="${FLASK_PORT}" \
  -v "${PWD}/app":/app \
  -p "${FLASK_PORT}":80 \
  -d \
  --link "${MYSQL_SERVER}":mysql \
  --name "${FLASK_APP}" \
  loreprospector/db-gate:1.0 \
  bash

