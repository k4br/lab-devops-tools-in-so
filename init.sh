FILE='/etc/selinux/config.bkp'
ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO='/home/vagrant/controle/01.controle'
if [ -f $FILE ]; then
	echo "File $FILE exists."
else
	echo "File $FILE does not exist."
	echo "Executando arquivo init.sh"
	cp /etc/selinux/config /etc/selinux/config.bkp
	setenforce 0
	sed '/SELINUX=/ s/enforcing/disabled/g' /etc/selinux/config.bkp > /etc/selinux/config
	echo "Inicio - criando diretorio de controle"
	mkdir /home/vagrant/controle
	touch $ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO
	echo "Fim - criando diretorio de controle"
	echo "Configurando - timezone America/Sao_Paulo"
	sudo timedatectl set-timezone America/Sao_Paulo
	echo "Hota Atual"
	date
fi

