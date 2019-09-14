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
		#https://wiki.jenkins.io/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions
		echo "Instalando Jenkins"
		sudo yum install wget -y
		sudo yum install git -y
		sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
		sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
		sudo yum install -y jenkins
		sudo yum install -y java
		sudo service jenkins start
		sudo chkconfig jenkins on
		echo "Fim instalação Jenkins"
		sudo mv $ARQUIVO_CONTROLE.inicio $ARQUIVO_CONTROLE
		echo "Fim Inatalação."
	fi
fi
