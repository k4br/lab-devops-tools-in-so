# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #zbxmariadb01 Servidor generico de Zabbix
  config.vm.define "zbxmariadb01" do |zbxmariadb01|
	zbxmariadb01.vm.provision :shell, path: "init.sh"
	zbxmariadb01.trigger.after [:up, :reload] do |trigger|
		trigger.run_remote = {inline: "bash /vagrant/install.zbxmariadb.sh"}
	end	
    zbxmariadb01.vm.hostname = "zbxmariadb01"
    zbxmariadb01.vm.box = "centos/7"
	zbxmariadb01.vm.network "private_network", ip: "192.168.10.100"
    zbxmariadb01.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "1" ]
        v.customize [ "modifyvm", :id, "--memory", "512" ]
    end
  end
  #zbxmariadb01
  #zbxserver01 Servidor generico de Zabbix
  config.vm.define "zbxserver01" do |zbxserver01|
	zbxserver01.vm.provision :shell, path: "init.sh"
	zbxserver01.trigger.after [:up, :reload] do |trigger|
		#trigger.run_remote = {inline: "bash /vagrant/install.zbxserver.sh"}
	end	
    zbxserver01.vm.hostname = "zbxserver01"
    zbxserver01.vm.box = "centos/7"
	zbxserver01.vm.network "private_network", ip: "192.168.10.101"
    zbxserver01.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "1" ]
        v.customize [ "modifyvm", :id, "--memory", "512" ]
    end
  end
  #zbxserver01


end