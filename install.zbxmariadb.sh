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
		#https://siteesite.com.br/kb/instale-o-mariadb-no-centos-7/
		sudo yum install -y  mariadb-server-1:5.5.60-1.el7_5.x86_64
		sudo systemctl start mariadb.service
		sudo systemctl enable mariadb.service
		printf "\n y\n abc\n abc\n y\n y\n y\n y\n" | sudo mysql_secure_installation
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		echo "Fim Inatalação."
	fi
fi
