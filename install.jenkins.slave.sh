#!/bin/bash
source /vagrant/functions.sh
#Arquivo de controle de instalacao
ARQUIVO_CONTROLE='/home/vagrant/controle/install.controle'
ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO='/home/vagrant/controle/01.controle'
ARQUIVO_CONTROLE_SEGUNDA_EXECUCAO='/home/vagrant/controle/02.controle'
SH_NAME="$(basename $BASH_SOURCE)"
logging "$SH_NAME - Inicio - install arquivo .sh primcipal"
if [ -f $ARQUIVO_CONTROLE ]; then
	logging "$SH_NAME - Inatalação já executada"
else
	if [ -f $ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO ]; then
		logging "$SH_NAME - Primeira execução noa executar instalação."
		sudo mv $ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO $ARQUIVO_CONTROLE_SEGUNDA_EXECUCAO
	else
		logging "$SH_NAME - Inicio - Inatalação"
		logging "$SH_NAME - Criando arquivo de controle"
		sudo touch $ARQUIVO_CONTROLE.inicio
		logging "$SH_NAME - Inicio -  Chamando script default de instalação [/vagrant/install.default.sh]"
		bash /vagrant/install.default.sh
		logging "$SH_NAME - Fim -  Chamando script default de instalação [/vagrant/install.default.sh]"
		logging "$SH_NAME - Inicio -  Instalação do Jenkins Slave"
		logging "$SH_NAME - Inicio -  Instalação git java"
		sudo yum install -y java-11-openjdk-devel
		logging "$SH_NAME - Fim -  Instalação git java"
		logging "$SH_NAME - Inicio -  criacao usuario jenkins e chave RSA"				
		sudo adduser -d /var/lib/jenkins jenkins
		sudo mkdir /var/lib/jenkins/.ssh
		sudo ssh-keygen -N "" -f /var/lib/jenkins/.ssh/id_rsa
		sudo cp /var/lib/jenkins/.ssh/id_rsa.pub /var/lib/jenkins/.ssh/authorized_keys
		sudo chown -R jenkins:jenkins /var/lib/jenkins
		logging "$SH_NAME - Inicio>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Chave RSA"
		sudo  cat /var/lib/jenkins/.ssh/id_rsa		
		logging "$SH_NAME - Fin<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Chave RSA"
		logging "$SH_NAME - Fim -  criacao usuario jenkins e chave RSA"					
		logging "$SH_NAME - Inicio -  Instalação do Jenkins Slave"
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		logging "$SH_NAME - Fim - Inatalação."
	fi
fi
logging "$SH_NAME - Fim - install arquivo .sh primcipal"

