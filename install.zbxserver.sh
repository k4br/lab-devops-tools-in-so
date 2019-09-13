#Arquivo de controle de instalacao
ARQUIVO_CONTROLE='/home/vagrant/controle/install.controle'
ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO='/home/vagrant/controle/01.controle'
ARQUIVO_CONTROLE_SEGUNDA_EXECUCAO='/home/vagrant/controle/02.controle'
echo "Hota Atual"
date
if [ -f $ARQUIVO_CONTROLE ]; then
	echo "Inatalação já executada"
else
	if [ -f $ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO ]; then
		echo "Primeira execução noa executar instalação."
		sudo mv $ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO $ARQUIVO_CONTROLE_SEGUNDA_EXECUCAO
	else
		echo "Inicio Inatalação."
		echo "Criando arquivo de controle"
		sudo touch $ARQUIVO_CONTROLE.inicio
		echo "executando Update"
		sudo yum update -y
		sudo yum install wget vim -y
		echo "Instalando Zabbix"		
		sudo yum install -y  epel-release		
		sudo yum update -y
		sudo yum -y install yum-utils
		sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
		sudo yum-config-manager --enable remi-php72		
		echo "Desabilitando o serviço firewalld do CentOS"	
		sudo systemctl disable firewalld
		sudo systemctl stop firewalld		
		sudo yum -y install nano		
		sudo rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
		sudo yum -y install zabbix-server-mysql zabbix-web-mysql zabbix-agent zabbix-get zabbix-sender
		mysql -uroot --password=abc -e "create database zabbix character set utf8 collate utf8_bin;grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix_pw';"		
		sudo zcat /usr/share/doc/zabbix-server-mysql-4.2.*/create.sql.gz | mysql -uzabbix -p zabbix --password=zabbix_pw
		mysql -uzabbix -p zabbix --password=zabbix_pw -e "show tables"		
		sudo cp /etc/zabbix/zabbix_server.conf /etc/zabbix/zabbix_server.conf.bkp
		sudo sed 's/# DBPassword=/DBPassword=zabbix_pw/g' /etc/zabbix/zabbix_server.conf.bkp > zabbix_server.conf
		sudo cp zabbix_server.conf /etc/zabbix/zabbix_server.conf
		sudo cp /etc/httpd/conf.d/zabbix.conf /etc/httpd/conf.d/zabbix.conf.bkp
		sudo sed 's/<IfModule mod_php5.c>/<IfModule mod_php7.c>/g' /etc/httpd/conf.d/zabbix.conf.bkp > zabbix.conf
		sudo cp zabbix.conf /etc/httpd/conf.d/zabbix.conf
		sudo rm  zabbix.conf
		sudo sed 's/# php_value date.timezone Europe/php_value date.timezone America/g' /etc/httpd/conf.d/zabbix.conf | sudo sed 's/Riga/Sao_Paulo/g'  > zabbix.conf		
		sudo cp zabbix.conf /etc/httpd/conf.d/zabbix.conf		
		sudo systemctl restart zabbix-server zabbix-agent httpd
		sudo systemctl enable zabbix-server zabbix-agent httpd	
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		echo "Fim Inatalação."
	fi
fi
