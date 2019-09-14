#Arquivo de controle de instalacao
ARQUIVO_CONTROLE='/home/vagrant/controle/install.controle'
ARQUIVO_CONTROLE_PRIMEIRA_EXECUCAO='/home/vagrant/controle/01.controle'
ARQUIVO_CONTROLE_SEGUNDA_EXECUCAO='/home/vagrant/controle/02.controle'
echo "Hota Atual"
date
if [ -f $ARQUIVO_CONTROLE ]; then
	echo "Inatalação já executada"
	echo "Inicio>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Chave RSA"
	sudo  cat /var/lib/jenkins/.ssh/id_rsa		
	echo "Fin<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Chave RSA"	
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
		echo "Inicio Inatalação slave"
		sudo yum install wget -y
		sudo yum install git -y		
		sudo yum install -y java
		sudo adduser -d /var/lib/jenkins jenkins
		sudo mkdir /var/lib/jenkins/.ssh
		sudo ssh-keygen -N "" -f /var/lib/jenkins/.ssh/id_rsa
		sudo cp /var/lib/jenkins/.ssh/id_rsa.pub /var/lib/jenkins/.ssh/authorized_keys
		sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/
		echo "Inicio>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Chave RSA"
		sudo  cat /var/lib/jenkins/.ssh/id_rsa		
		echo "Fin<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Chave RSA"		
		echo "Fim Inatalação slave"
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		echo "Fim Inatalação."
	fi
fi
