# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#jenkinsmaster01
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
end