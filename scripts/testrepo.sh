#!/usr/bin/env bash

source /vagrant/scripts/secrets.sh

# Create a repo
svnadmin create /var/www/svn/testrepo


# Checkout a working copy of the repo
svn co file:///var/www/svn/testrepo /vagrant/svn/testrepo

# Create the skeleton of the repo and commit
mkdir /vagrant/svn/testrepo/trunk
mkdir /vagrant/svn/testrepo/branches
mkdir /vagrant/svn/testrepo/tags
svn add /vagrant/svn/testrepo/*
svn commit /vagrant/svn/testrepo/ -m "Initial repo skeleton."

# Make a few initial commits with some sample source.
cp /vagrant/scripts/resources/sample_source/r1/* /vagrant/svn/testrepo/trunk/
svn add /vagrant/svn/testrepo/trunk/*
svn commit /vagrant/svn/testrepo/trunk/ -m "Initial revision of PL/SQL."

rm -rf /vagrant/svn/testrepo/trunk/*
cp /vagrant/scripts/resources/sample_source/r2/* /vagrant/svn/testrepo/trunk/
svn commit /vagrant/svn/testrepo/trunk/ -m "Corrected a typo (too > two)."

rm -rf /vagrant/svn/testrepo/trunk/*
cp /vagrant/scripts/resources/sample_source/r3/* /vagrant/svn/testrepo/trunk/
svn commit /vagrant/svn/testrepo/trunk/ -m "Added the do_something_more procedure."
