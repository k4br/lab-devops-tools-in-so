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
		logging "Inicio -  Instalação do Jenkins Slave"
		logging "Inicio -  Instalação git java"
		sudo yum install git java -y
		logging "Fim -  Instalação git java"
		logging "Inicio -  criacao usuario jenkins e chave RSA"				
		sudo adduser -d /var/lib/jenkins jenkins
		sudo mkdir /var/lib/jenkins/.ssh
		sudo ssh-keygen -N "" -f /var/lib/jenkins/.ssh/id_rsa
		sudo cp /var/lib/jenkins/.ssh/id_rsa.pub /var/lib/jenkins/.ssh/authorized_keys
		sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/
		logging "Inicio>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Chave RSA"
		sudo  cat /var/lib/jenkins/.ssh/id_rsa		
		logging "Fin<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Chave RSA"
		logging "Fim -  criacao usuario jenkins e chave RSA"					
		logging "Inicio -  Instalação do Jenkins Slave"
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		logging "Fim - Inatalação."
	fi
fi
logging "Fim - install arquivo .sh primcipal"
