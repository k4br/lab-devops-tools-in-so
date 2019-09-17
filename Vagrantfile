# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #zbxmariadb01 Servidor generico de Zabbix
  config.vm.define "zbxmariadb01" do |zbxmariadb01|
	zbxmariadb01.vm.provision :shell, path: "init.sh"
	zbxmariadb01.trigger.after [:up, :reload] do |trigger|
		trigger.run_remote = {inline: "bash /vagrant/install.zabbix.mariadb.sh | tee -a install.log"}
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
		trigger.run_remote = {inline: "bash /vagrant/install.zabbix.server.sh | tee -a install.log"}
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
  #jenksmaster01 Servidor generico de Zabbix
  config.vm.define "jenksmaster01" do |jenksmaster01|
	jenksmaster01.vm.provision :shell, path: "init.sh"
	jenksmaster01.trigger.after [:up, :reload] do |trigger|
		trigger.run_remote = {inline: "bash /vagrant/install.jenks.master.sh | tee -a install.log"}
	end
    jenksmaster01.vm.hostname = "jenksmaster01"
    jenksmaster01.vm.box = "centos/7"
	jenksmaster01.vm.network "private_network", ip: "192.168.10.102"
    jenksmaster01.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "2" ]
        v.customize [ "modifyvm", :id, "--memory", "2048" ]
    end
  end
  #jenksmaster01
  #jenksslave01 Servidor generico de Zabbix
  config.vm.define "jenksslave01" do |jenksslave01|
	jenksslave01.vm.provision :shell, path: "init.sh"
	jenksslave01.trigger.after [:up, :reload] do |trigger|
		trigger.run_remote = {inline: "bash /vagrant/install.jenks.slave.sh | tee -a install.log"}
	end
    jenksslave01.vm.hostname = "jenksslave01"
    jenksslave01.vm.box = "centos/7"
	jenksslave01.vm.network "private_network", ip: "192.168.10.103"
    jenksslave01.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "1" ]
        v.customize [ "modifyvm", :id, "--memory", "1024" ]
    end
  end
  #jenksslave01
  #docker01 Servidor generico de Zabbix
  config.vm.define "docker01" do |docker01|
	docker01.vm.provision :shell, path: "init.sh"
	docker01.trigger.after [:up, :reload] do |trigger|
		trigger.run_remote = {inline: "bash /vagrant/install.docker.sh | tee -a install.log"}
	end
    docker01.vm.hostname = "docker01"
    docker01.vm.box = "centos/7"
	docker01.vm.network "private_network", ip: "192.168.10.104"
    docker01.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "1" ]
        v.customize [ "modifyvm", :id, "--memory", "1024" ]
    end
  end
  #docker01


end