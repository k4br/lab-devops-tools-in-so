#!/bin/bash
source /vagrant/functions.sh
logging "Inicio - install.default"
logging "Inicio - desabilitação do firewalld"
sudo systemctl disable firewalld
sudo systemctl stop firewalld
logging "Fim - desabilitação do firewalld"
logging "Inicio - update"		
sudo yum update -y
logging "Fim - update"
logging "Inicio - Instalação wget vim nano"	
sudo yum install wget vim nano -y
logging "Fim - Instalação wget vim nano"
logging "Inicio - Instalação Repositório"		
sudo yum install -y  epel-release
logging "Fim - Instalação Repositório"
logging "Inicio - update"			
sudo yum update -y
logging "Fim - update"
logging "Inicio - Instalação yum-utils"
sudo yum -y install yum-utils
logging "Fim - Instalação yum-utils"
logging "Inicio - Instalação zabbix-agent zabbix-sender"
sudo rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
sudo yum -y install zabbix-agent zabbix-sender
logging "Inicio - start serviço zabbix-agent"	
sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent
logging "Fim - start serviço zabbix-agent"	
logging "Inicio - Configuração arquivo zabbix_agentd.conf"
sudo cp /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.bkp
sudo sed 's/Server=127.0.0.1/Server=192.168.10.101/g' /etc/zabbix/zabbix_agentd.conf.bkp | sudo sed 's/ServerActive=127.0.0.1/ServerActive=192.168.10.101/g' | sudo sed "s/Hostname=Zabbix server/Hostname=$(hostname)/g" > zabbix_agentd.conf
sudo cp zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf
logging "Fim - Configuração arquivo zabbix_agentd.conf"
logging "Inicio - restart serviço zabbix-agent"	
sudo systemctl restart zabbix-agent
logging "Fim - restart serviço zabbix-agent"	
logging "Fim - Instalação zabbix-agent zabbix-sender"
logging "Fim - install.default"