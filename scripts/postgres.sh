#!/usr/bin/env bash

source /vagrant/scripts/secrets.sh

PG_CONF="/var/lib/pgsql/9.4/data/postgresql.conf"
PG_HBA="/var/lib/pgsql/9.4/data/pg_hba.conf"

# Add the Postgres yum repo and install latest postgres.
wget -q -P ~ http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
rpm -i --quiet -U ~/pgdg-centos94-9.4-1.noarch.rpm
yum install -y postgresql94-server

# Initialise the database.
service postgresql-9.4 initdb

# Set the password for the 'postgres' user.
echo -e "$POSTGRES_PASSWORD\n$POSTGRES_PASSWORD" | (sudo passwd postgres)

# Explicitly set default client_encoding
echo "client_encoding = utf8" >> "$PG_CONF"

service postgresql-9.4 start

cat << EOF | su - postgres -c psql
CREATE USER $REVIEWBOARD_DB_USER WITH PASSWORD '$REVIEWBOARD_DB_PASSWORD';
CREATE DATABASE $REVIEWBOARD_DB_NAME WITH OWNER=$REVIEWBOARD_DB_USER ENCODING='UTF8' TEMPLATE=template1;
EOF

# Append to pg_hba.conf to add password auth:
sed -i "s/local   all/#local   all/g" "$PG_HBA"
sed -i "s/host    all/#host    all/g" "$PG_HBA"

echo "host     $REVIEWBOARD_DB_NAME     $REVIEWBOARD_DB_USER          127.0.0.1/32            md5" >> "$PG_HBA"
echo "host     $REVIEWBOARD_DB_NAME     $REVIEWBOARD_DB_USER          ::1/128                 md5" >> "$PG_HBA"
echo "local    $REVIEWBOARD_DB_NAME     $REVIEWBOARD_DB_USER                                  md5" >> "$PG_HBA"

# Restart so that all new config is loaded:
service postgresql-9.4 restart
