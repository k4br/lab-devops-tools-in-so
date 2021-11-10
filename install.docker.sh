#!/bin/bash
source /vagrant/functions.sh
#Arquivo de controle de instalacao
ARQUIVO_CONTROLE='/home/vagrant/controle/install.controle'
ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO='/home/vagrant/controle/01.controle'
ARQUIVO_CONTROLE_SEGUNDA_EXECUCAO='/home/vagrant/controle/02.controle'
logging "Inicio - install arquivo .sh primcipal"
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
		logging "Inicio -  Instalação do docker e docker-compose"
		sudo yum install -y device-mapper-persistent-data lvm2
		sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
		sudo yum install -y docker-ce docker-ce-cli containerd.io
		sudo systemctl start docker
		sudo systemctl enable docker
		curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
		sudo chmod +x /usr/local/bin/docker-compose		
		logging "Inicio -  Instalação do docker e docker-compose"
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		logging "Fim - Inatalação."
	fi
fi
logging "Fim - install arquivo .sh primcipal"

