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

DOCKER_INTERNAL_NEWTWORK='lorehaven'

MYSQL_PORT='3306'
FLASK_PORT='80'

MYSQL_SERVER='mysql'
FLASK_APP='gate'

docker volume create "${MYSQL_SHARED_VOLUME}"
docker network create "${DOCKER_INTERNAL_NETWORK}"

docker run \
  -e MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}" \
  -e MYSQL_DATABASE="${MYSQL_DATABASE}" \
  -e MYSQL_USER="${MYSQL_USER}" \
  -e MYSQL_PASSWORD="${MYSQL_PASSWORD}" \
  -v "${MYSQL_SHARED_VOLUME}":/var/lib/mysql \
  -p "${MYSQL_PORT}":3306 \
  -d \
  --net "${DOCKER_INTERNAL_NETWORK}" \
  --restart=always \
  --name "${MYSQL_SERVER}" \
  mariadb:10.3

docker run \
  -v "${PWD}/sql":/sql \
  --net "${DOCKER_INTERNAL_NETWORK}" \
  --rm \
  loreprospector/mysql-client:1.0 \
  cat \
  /sql/create_db.sql \
  /sql/init_db.sql \
  | mysql \
  -uroot \
  -p"${MYSQL_ROOT_PASSWORD}" \
  -h "${MYSQL_SERVER}.${DOCKER_INTERNAL_NETWORK}" \
  -P 3306

docker run \
  -v "${PWD}/app":/app \ 
  -p "${FLASK_PORT}":80 \
  -d \
  --net "${DOCKER_INTERNAL_NETWORK}" \
  --restart=always \
  --name "${FLASK_APP}" \
  loreprospector/flask-sql:1.0 \
  flask run \
  --host=0.0.0.0 \
  --port=80
