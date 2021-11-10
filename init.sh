#!/bin/bash
source /vagrant/functions.sh
FILE='/etc/selinux/config.bkp'
#SH_NAME="$(basename $BASH_SOURCE)"
SH_NAME="init.sh"
ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO='/home/vagrant/controle/01.controle'
touch /home/vagrant/install.log
chmod 777 /home/vagrant/install.log
if [ -f $FILE ]; then
	logging "$SH_NAME - File $FILE exists."
	logging "$SH_NAME - Nao Executando arquivo init.sh"
	logging "$SH_NAME - Nao foi executada a instalacao inicial, essa ja executada anteriormente." 1	
else
	logging "$SH_NAME - File $FILE does not exist."
	logging "$SH_NAME - Executando arquivo init.sh"
	cp /etc/selinux/config /etc/selinux/config.bkp
	setenforce 0
	sed '/SELINUX=/ s/enforcing/disabled/g' /etc/selinux/config.bkp > /etc/selinux/config
	logging "$SH_NAME - Inicio - criando diretorio de controle"
	mkdir /home/vagrant/controle
	touch $ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO
	logging "$SH_NAME - Fim - criando diretorio de controle"
	logging "$SH_NAME - Configurando - timezone America/Sao_Paulo"
	logging "$SH_NAME - Hora Atual Antes do ajuste:$(date +%m-%d-%Y-%H:%M:%S.%3N)"
	sudo timedatectl set-timezone America/Sao_Paulo
		logging "$SH_NAME - Hora Atual Depois do ajuste:$(date +%m-%d-%Y-%H:%M:%S.%3N)"
	date
fi

