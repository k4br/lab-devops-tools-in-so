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
		logging "Inicio - Configuracao php72"
		sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
		sudo yum-config-manager --enable remi-php72
		logging "Fim - Configuracao php72"
		logging "Inicio -  Chamando script default de instalação [/vagrant/install.default.sh]"
		bash /vagrant/install.default.sh
		logging "Fim -  Chamando script default de instalação [/vagrant/install.default.sh]"
		logging "Inicio - Instalação zabbix"
		#O comando comentado abaixo ja é executado no install.default
		#sudo rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
		logging "Inicio - instalando zabbix-server-mysql zabbix-web-mysql zabbix-get"
		sudo yum -y install zabbix-server-mysql zabbix-web-mysql zabbix-get
		logging "Fim - instalando zabbix-server-mysql zabbix-web-mysql zabbix-get"
		logging "Inicio - instalando mysql"
		sudo yum -y install mysql
		logging "Fim - instalando mysql"
		logging "Inicio - Criando estrutura de tabelas Madia DB"
		sudo zcat /usr/share/doc/zabbix-server-mysql-4.2.*/create.sql.gz | mysql -uzabbix -p zabbix -h 192.168.10.100 --password=zabbix_pw
		logging "Fim - Criando estrutura de tabelas Madia DB"
		logging "Inicio - Configuração arquivo /etc/zabbix/zabbix_server.conf"
		sudo cp /etc/zabbix/zabbix_server.conf /etc/zabbix/zabbix_server.conf.bkp
		sudo sed 's/# DBPassword=/DBPassword=zabbix_pw/g' /etc/zabbix/zabbix_server.conf.bkp | sudo sed 's/# DBHost=localhost/DBHost=192.168.10.100/g' > zabbix_server.conf
		sudo cp zabbix_server.conf /etc/zabbix/zabbix_server.conf
		logging "Fim - Configuração arquivo /etc/zabbix/zabbix_server.conf"
		logging "Inicio - Configuração arquivo /etc/httpd/conf.d/zabbix.conf"
		sudo cp /etc/httpd/conf.d/zabbix.conf /etc/httpd/conf.d/zabbix.conf.bkp
		sudo sed 's/<IfModule mod_php5.c>/<IfModule mod_php7.c>/g' /etc/httpd/conf.d/zabbix.conf.bkp > zabbix.conf
		sudo cp zabbix.conf /etc/httpd/conf.d/zabbix.conf
		sudo rm  zabbix.conf
		sudo sed 's/# php_value date.timezone Europe/php_value date.timezone America/g' /etc/httpd/conf.d/zabbix.conf | sudo sed 's/Riga/Sao_Paulo/g'  > zabbix.conf		
		sudo cp zabbix.conf /etc/httpd/conf.d/zabbix.conf
		
		logging "Inicio - Configuração arquivo /etc/zabbix/zabbix_agentd.conf"
		logging "Para esse ambiente a configuração deve ficar com o arquivo original [/etc/zabbix/zabbix_agentd.conf]"
		sudo cp /etc/zabbix/zabbix_agentd.conf.bkp /etc/zabbix/zabbix_agentd.conf
		logging "Fim - Configuração arquivo /etc/zabbix/zabbix_agentd.conf"
		
		logging "Fim - Configuração arquivo /etc/httpd/conf.d/zabbix.conf"
		logging "Inicio - Restart serviço zabbix-server zabbix-agent httpd"			
		sudo systemctl restart zabbix-server zabbix-agent httpd
		sudo systemctl enable zabbix-server zabbix-agent httpd	
		logging "Fim - Restart serviço zabbix-server zabbix-agent httpd"		
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		logging "Fim - Inatalação."
	fi
fi
logging "Fim - install arquivo .sh primcipal"
