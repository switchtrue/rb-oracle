chkconfig --add postgresql-9.4
chkconfig --level 234 postgresql-9.4 on

chkconfig --add httpd
chkconfig --level 234 httpd on

service postgresql-9.4 restart
service httpd restart
