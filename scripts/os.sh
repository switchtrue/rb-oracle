#!/usr/bin/env bash

source /vagrant/scripts/secrets.sh

# Update all packages
# yum -y updatee

# Set the timezone to Canberra
echo "Setting the timezone to Canberra"
rm /etc/localtime
ln -s /usr/share/zoneinfo/Australia/Canberra /etc/localtime

yum install wget -y
