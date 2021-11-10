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
		#https://www.jenkins.io/doc/book/installing/linux/#red-hat-centos
		logging "$SH_NAME - Inicio -  Instalação do Jenkins"
		sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
		sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
		sudo yum upgrade
		sudo yum install epel-release java-11-openjdk-devel
		sudo yum install jenkins
		sudo systemctl daemon-reload
		#You can start the Jenkins service with the command:
		sudo systemctl enable jenkins
		sudo systemctl start jenkins
		#You can check the status of the Jenkins service using the command:
		sudo systemctl status jenkins
		logging "$SH_NAME - Fim -  Instalação do Jenkins"
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		logging "$SH_NAME - Fim - Inatalação."
	fi
fi
logging "$SH_NAME - Fim - install arquivo .sh primcipal"

