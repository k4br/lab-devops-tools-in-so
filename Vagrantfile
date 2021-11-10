# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #zbxmariadb01 Servidor generico de Zabbix
  config.vm.define "zbxmariadb01" do |zbxmariadb01|
	#zbxmariadb01.vm.boot_timeout = 120
	zbxmariadb01.vm.provision :shell, path: "init.sh"
	zbxmariadb01.trigger.after [:up, :reload] do |trigger|
		trigger.run_remote = {inline: "bash /vagrant/install.zabbix.mariadb.sh | tee -a install.log"}
	end	
    zbxmariadb01.vm.hostname = "zbxmariadb01"
    zbxmariadb01.vm.box = "centos/7"
	zbxmariadb01.vm.network "private_network", ip: "192.168.10.100"
    zbxmariadb01.vm.provider "virtualbox" do |v|
		v.gui = true
        v.customize [ "modifyvm", :id, "--cpus", "8" ]
        v.customize [ "modifyvm", :id, "--memory", "5120" ]
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
  #jenkinsmaster01 Servidor generico de Zabbix
  config.vm.define "jenkinsmaster01" do |jenkinsmaster01|
	jenkinsmaster01.vm.provision :shell, path: "init.sh"
	jenkinsmaster01.trigger.after [:up, :reload] do |trigger|
		trigger.run_remote = {inline: "bash /vagrant/install.jenkins.master.sh | tee -a install.externo.log"}
	end
    jenkinsmaster01.vm.hostname = "jenkinsmaster01"
    jenkinsmaster01.vm.box = "centos/7"
	jenkinsmaster01.vm.network "private_network", ip: "192.168.10.102"
    jenkinsmaster01.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "2" ]
        v.customize [ "modifyvm", :id, "--memory", "2048" ]
    end
  end
  #jenkinsmaster01
  #jenkinsslave01 Servidor generico de Zabbix
  config.vm.define "jenkinsslave01" do |jenkinsslave01|
	jenkinsslave01.vm.provision :shell, path: "init.sh"
	jenkinsslave01.trigger.after [:up, :reload] do |trigger|
		trigger.run_remote = {inline: "bash /vagrant/install.jenkins.slave.sh | tee -a install.log"}
	end
    jenkinsslave01.vm.hostname = "jenkinsslave01"
    jenkinsslave01.vm.box = "centos/7"
	jenkinsslave01.vm.network "private_network", ip: "192.168.10.103"
    jenkinsslave01.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "1" ]
        v.customize [ "modifyvm", :id, "--memory", "1024" ]
    end
  end
  #jenkinsslave01
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
  #docker02 Servidor generico de Zabbix
  config.vm.define "docker02" do |docker02|
	docker02.vm.provision :shell, path: "init.sh"
	docker02.trigger.after [:up, :reload] do |trigger|
		trigger.run_remote = {inline: "bash /vagrant/install.docker.sh | tee -a install.log"}
	end
    docker02.vm.hostname = "docker02"
    docker02.vm.box = "centos/7"
	docker02.vm.network "private_network", ip: "192.168.10.105"
    docker02.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "1" ]
        v.customize [ "modifyvm", :id, "--memory", "1024" ]
    end
  end
  #docker02
  #gitlab01 Servidor generico de Zabbix
  config.vm.define "gitlab01" do |gitlab01|
	gitlab01.vm.provision :shell, path: "init.sh"
	gitlab01.trigger.after [:up, :reload] do |trigger|
		trigger.run_remote = {inline: "bash /vagrant/install.gitlab.sh | tee -a install.log"}
	end
    gitlab01.vm.hostname = "gitlab01"
    gitlab01.vm.box = "centos/7"
	gitlab01.vm.network "private_network", ip: "192.168.10.110"
    gitlab01.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "2" ]
        v.customize [ "modifyvm", :id, "--memory", "3072" ]
    end
  end
  #gitlab01


end