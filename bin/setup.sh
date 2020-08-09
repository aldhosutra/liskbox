#!/bin/bash

if ! id -u lisk > /dev/null 2>&1; then
    sudo adduser --disabled-password --gecos '' lisk && usermod -a -G sudo lisk && echo "lisk:$1" | chpasswd
fi

sudo apt-get purge -y postgres* 
sudo apt-get update
sudo apt-get install -y lsb-release libtool automake autoconf curl python2-minimal build-essential redis-server wget ca-certificates git language-pack-en

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
sudo apt-get update && apt-get upgrade -y
sudo apt-get install -y postgresql-10

# sudo apt-get install -y ufw
# sudo ufw enable
# sudo ufw allow http
# sudo ufw allow 6001/tcp
# sudo ufw allow 4000/tcp
# sudo ufw allow 5000/tcp

sudo pg_dropcluster --stop 10 main
sudo pg_createcluster --locale en_US.UTF-8 --start 10 main
sudo -u postgres -i createuser --createdb lisk
sudo -u postgres -i createdb lisk_dev --owner lisk
sudo -u postgres psql -d lisk_dev -c "alter user lisk with password '$1';"
