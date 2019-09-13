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
		echo "Instalando repositorio epel"
		sudo yum install -y  epel-release
		sudo yum update -y
		sudo yum -y install yum-utils
		
		sudo rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
		sudo yum -y install zabbix-agent zabbix-sender
		sudo systemctl start zabbix-agent
		sudo systemctl enable zabbix-agent
		sudo cp /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.bkp
		sudo sed 's/Server=127.0.0.1/Server=192.168.60.100/g' /etc/zabbix/zabbix_agentd.conf.bkp | sudo sed 's/ServerActive=127.0.0.1/ServerActive=192.168.60.100/g' | sudo sed "s/Hostname=Zabbix server/Hostname=$(hostname)/g" > zabbix_agentd.conf
		sudo cp zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf
		sudo systemctl restart zabbix-agent
		
		
		
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		echo "Fim Inatalação."
	fi
fi
