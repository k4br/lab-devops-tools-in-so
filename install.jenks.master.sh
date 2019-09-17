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
		#https://wiki.jenkins.io/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions
		logging "Inicio -  Instalação do Jenkins"
		sudo yum install git -y
		sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
		sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
		sudo yum install -y jenkins
		sudo yum install -y java
		sudo service jenkins start
		sudo chkconfig jenkins on
		logging "Inicio -  Instalação do Jenkins"
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		logging "Fim - Inatalação."
	fi
fi
logging "Fim - install arquivo .sh primcipal"
