#!/bin/bash

[[ "${EUID}" -ne "0" ]] \
  && { echo 'Root permisions required.' 1>&2; exit 1; }

yum install wget -y

# Download and add the repository, then update.
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update

rm -f ./mysql-community-release-el7-5.noarch.rpm

# Install MySQL and start the service.
yum install mysql-server -y
systemctl start mysqld

# Very secure way of storing a passwords.
ROOT_PASSWORD=

# Create database before password assigned.
mysql -u root < ./used_cars_store.sql

# Set up password, able remote connection,
# and remove unnecessary things.
mysql -u root -e "$(cat << END
UPDATE mysql.user SET Password=PASSWORD('${ROOT_PASSWORD}') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\\\_%';

CREATE USER 'root'@'%' IDENTIFIED BY '${ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';

FLUSH PRIVILEGES;
END
)"

