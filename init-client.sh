#!/bin/bash

[[ "${EUID}" -ne "0" ]] \
  && { echo 'Root permisions required.' 1>&2; exit 1; }

apt-get install mysql-client -y 

SQL_SERVER='35.176.206.50'
echo "${SQL_SERVER} sql" >> /etc/hosts

echo 'To connect to the database, use: mysql -u username -p -h sql.'
echo 'To init database, use: mysql -u username -p -h sql < ./mysql/init-db.sql'

