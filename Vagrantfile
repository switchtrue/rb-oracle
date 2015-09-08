# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "chef/centos-6.5"

  config.vm.provision "shell", :path => "scripts/os.sh"
  config.vm.provision "shell", :path => "scripts/postgres.sh"
  config.vm.provision "shell", :path => "scripts/apache.sh"
  config.vm.provision "shell", :path => "scripts/reviewboard.sh"
  config.vm.provision "shell", :path => "scripts/startupservices.sh"
  config.vm.provision "shell", :path => "scripts/svn.sh"
  config.vm.provision "shell", :path => "scripts/testrepo.sh"

  config.vm.network "forwarded_port", guest: 80, host: 10080

end
