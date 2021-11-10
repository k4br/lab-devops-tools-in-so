#!/bin/bash
source /vagrant/functions.sh
logging "Inicio - install arquivo .sh primcipal"
#Arquivo de controle de instalacao
ARQUIVO_CONTROLE='/home/vagrant/controle/install.controle'
ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO='/home/vagrant/controle/01.controle'
ARQUIVO_CONTROLE_SEGUNDA_EXECUCAO='/home/vagrant/controle/02.controle'
if [ -f $ARQUIVO_CONTROLE ]; then
	logging "Inatalação já executada"
else
	if [ -f $ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO ]; then
		logging "Primeira execução noa executar instalação."
		sudo mv $ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO $ARQUIVO_CONTROLE_SEGUNDA_EXECUCAO
	else
		logging "Inicio - Inatalação"
		logging "Criando arquivo de controle"
		sudo touch $ARQUIVO_CONTROLE.inicio
		logging "Inicio -  Chamando script default de instalação [/vagrant/install.default.sh]"
		bash /vagrant/install.default.sh
		logging "Fim -  Chamando script default de instalação [/vagrant/install.default.sh]"
		logging "Inicio - Instalação mariadb"	
		#https://siteesite.com.br/kb/instale-o-mariadb-no-centos-7/
		sudo yum install -y  mariadb-server
		sudo systemctl start mariadb.service
		sudo systemctl enable mariadb.service
		logging "Configurando mariadb com comando mysql_secure_installation"
		printf "\n y\n abc\n abc\n y\n y\n y\n y\n" | sudo mysql_secure_installation
		logging "Inicio - Criando usuário e esquemas do zabbix no BD"
		mysql -uroot --password=abc -e "create database zabbix character set utf8 collate utf8_bin;grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix_pw';"
		#Permite acesso de qualquer IP para o usuario:zabbix_pw
		mysql -uroot --password=abc -e "grant all privileges on zabbix.* to 'zabbix'@'%' identified by 'zabbix_pw';"
		logging "Fim - Criando usuário e esquemas do zabbix no BD"
		logging "Fim - Instalação mariadb"
		showmount -e 192.168.104.231
		mkdir /tmp/nfsfileshare
		mount 192.168.104.231:/nfsfileshare /tmp/nfsfileshare
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		logging "Fim - Inatalação."
	fi
fi
logging "Fim - install arquivo .sh primcipal"
