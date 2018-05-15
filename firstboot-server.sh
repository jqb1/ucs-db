#!/bin/bash

[[ "${EUID}" -ne "0" ]] \
  && { echo 'Root permisions required.' 1>&2; exit 1; }

rpm -ivh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

yum update -y
yum install mysql-server -y

systemctl start mysqld

mysql -u root < ./sql/clean_mysql.sql
mysql -u root < ./sql/create_db.sql
# mysql -u root < ./sql/init_db.sql

MYSQL_ROOT_PASSWORD=admin1

mysql -u root -e "$(cat << END
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';
FLUSH PRIVILEGES
END
)"

cat << 'END' > /etc/yum.repos.d/centos.repo
[CentOS-extras]
name=CentOS-7-Extras
mirrorlist=http://mirrorlist.centos.org/?release=7&arch=$basearch&repo=extras&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
END

yum install docker -y

#docker build -t sql ./sql
#docker run -p 3306:3306 -d sql

docker build -t app ./app # 500Mb
docker run -p 7777:80 -d -v ${PWD}/app:/app app

