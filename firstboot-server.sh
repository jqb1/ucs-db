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

