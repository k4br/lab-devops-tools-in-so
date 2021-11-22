#!/bin/bash
source /vagrant/functions.sh
SH_NAME="$(basename $BASH_SOURCE)"
logging "$SH_NAME - Inicio - install.default"
logging "$SH_NAME - Inicio - desabilitação do firewalld"
sudo systemctl disable firewalld
sudo systemctl stop firewalld
logging "$SH_NAME - Fim - desabilitação do firewalld"
logging "$SH_NAME - Inicio - update"		
sudo yum update -y 
logging "$SH_NAME - Fim - update"
logging "$SH_NAME - Inicio - Instalação wget vim nano"	
sudo yum install wget vim nano -y 
logging "$SH_NAME - Fim - Instalação wget vim nano"
logging "$SH_NAME - Inicio - Instalação Repositório"		
sudo yum install -y  epel-release 
logging "$SH_NAME - Fim - Instalação Repositório"
logging "$SH_NAME - Inicio - update"			
sudo yum update -y 
logging "$SH_NAME - Fim - update"
logging "$SH_NAME - Inicio - Instalação yum-utils"
sudo yum -y install yum-utils 
logging "$SH_NAME - Fim - Instalação yum-utils"
#logging "$SH_NAME - Inicio - Instalação zabbix-agent zabbix-sender"
#sudo rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
#sudo yum -y install zabbix-agent zabbix-sender 
#logging "$SH_NAME - Inicio - start serviço zabbix-agent"	
#sudo systemctl start zabbix-agent
#sudo systemctl enable zabbix-agent
#logging "$SH_NAME - Fim - start serviço zabbix-agent"	
#logging "$SH_NAME - Inicio - Configuração arquivo zabbix_agentd.conf"
#sudo cp /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.bkp
#sudo sed 's/Server=127.0.0.1/Server=192.168.10.101/g' /etc/zabbix/zabbix_agentd.conf.bkp | sudo sed 's/ServerActive=127.0.0.1/ServerActive=192.168.10.101/g' | sudo sed "s/Hostname=Zabbix server/Hostname=$(hostname)/g" > zabbix_agentd.conf
#sudo cp zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf
#logging "$SH_NAME - Fim - Configuração arquivo zabbix_agentd.conf"
#logging "$SH_NAME - Inicio - restart serviço zabbix-agent"	
#sudo systemctl restart zabbix-agent
#logging "$SH_NAME - Fim - restart serviço zabbix-agent"	
#logging "$SH_NAME - Fim - Instalação zabbix-agent zabbix-sender"
logging "$SH_NAME - Inicio - Instalação git"	
sudo yum install git -y
logging "$SH_NAME - Fim - Instalação git"
logging "$SH_NAME - Inicio - Instalação JSON processor"
sudo yum install jq -y
logging "$SH_NAME - Fim - Instalação JSON processor"
logging "$SH_NAME - Fim - install.default"
