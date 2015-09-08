#!/usr/bin/env bash

source /vagrant/scripts/secrets.sh

yum install -y memcached
yum -y install postgresql-libs
yum -y install python-psycopg2

service postgresql-9.4 start

# Install Review Board 2.0
yum -y groupinstall "Development tools"
yum -y install python2-devel
yum install -y python-setuptools
easy_install -f http://downloads.reviewboard.org/releases/ReviewBoard/2.0/ -U ReviewBoard

# Create the RB site
rb-site install /var/www/reviewboard --noinput --domain-name=localhost --site-root=/ --db-type=postgresql --db-name=$REVIEWBOARD_DB_NAME --db-user=$REVIEWBOARD_DB_USER --db-pass=$REVIEWBOARD_DB_PASSWORD --cache-type=memcached --cache-info=localhost:11211 --admin-user=$REVIEW_BOARD_ADMIN_NAME --admin-password=$REVIEW_BOARD_ADMIN_PASSWORD --admin-email=$REVIEW_BOARD_ADMIN_NAME@reviewboard.localhost.com

# Setup the cronjob to periodically update the search index and kick off an index now.
crontab /var/www/reviewboard/conf/cron.conf
rb-site manage /var/www/reviewboard index -- --full

# Review Board apache config
cp /var/www/reviewboard/conf/apache-wsgi.conf /etc/httpd/conf.d/apache-wsgi.conf

# Sort out required directory permissions
sudo chown -R apache "/var/www/reviewboard/data"
sudo chown -R apache "/var/www/reviewboard/htdocs/media/ext"
sudo chown -R apache "/var/www/reviewboard/htdocs/static/ext"

# Install subvertpy
yum -y install subversion-devel
easy_install pip
pip install subvertpy

# Install pysvn
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh epel-release*rpm
yum -y install pysvn

# Set the Review Board SVN backend to use pysvn
echo "" >> /var/www/reviewboard/conf/settings_local.py
echo "SVNTOOL_BACKENDS = [" >> /var/www/reviewboard/conf/settings_local.py
echo "    'reviewboard.scmtools.svn.pysvn'" >> /var/www/reviewboard/conf/settings_local.py
echo "]" >> /var/www/reviewboard/conf/settings_local.py
