# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#http://gutocarvalho.net/octopress/2014/05/12/vagrant-multi-machines/
  #zbxserver01 Servidor generico de mongo
  config.vm.define "zbxserver01" do |zbxserver01|
	zbxserver01.vm.provision :shell, path: "init.sh"
	zbxserver01.trigger.after [:up, :reload] do |trigger|
		#trigger.info = "Running init_open_shift.sh locally..."
		trigger.run_remote = {inline: "bash /vagrant/install.zbxserver.sh"}
	end
	
    zbxserver01.vm.hostname = "zbxserver01"

    zbxserver01.vm.box = "centos/7"

	zbxserver01.vm.network "private_network", ip: "192.168.60.100"


    zbxserver01.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "1" ]
        v.customize [ "modifyvm", :id, "--memory", "1024" ]
    end

  end
  #zbxserver01
  
  #zbxagent01 Servidor generico de mongo
  config.vm.define "zbxagent01" do |zbxagent01|
	zbxagent01.vm.provision :shell, path: "init.sh"
	zbxagent01.trigger.after [:up, :reload] do |trigger|
		#trigger.info = "Running init_open_shift.sh locally..."
		trigger.run_remote = {inline: "bash /vagrant/install.zbxagent.sh"}
	end
	
    zbxagent01.vm.hostname = "zbxagent01"

    zbxagent01.vm.box = "centos/7"

	zbxagent01.vm.network "private_network", ip: "192.168.60.101"


    zbxagent01.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "1" ]
        v.customize [ "modifyvm", :id, "--memory", "1024" ]
    end

  end
  #zbxagent01


end
