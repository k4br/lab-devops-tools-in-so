#!/bin/bash
logging() {
    echo `date +%m-%d-%Y-%H:%M:%S.%3N` " - $1" | tee -a /home/vagrant/install.log
}
