#!/usr/bin/env bash

source /vagrant/scripts/secrets.sh

yum -y install mod_dav_svn subversion

# Create a directory for the repos
 mkdir /var/www/svn

# Set up the apache config.
cp /vagrant/scripts/resources/subversion.conf /etc/httpd/conf.d/svn.conf
