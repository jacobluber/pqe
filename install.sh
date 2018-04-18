#!/bin/bash
#installing hutlab tools

#humann2
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install pip
pip install humann2
mkdir h2db 
humann2_databases --download chocophlan full /home/ubuntu/h2db
humann2_databases --download uniref uniref90_ec_filtered_diamond /home/ubuntu/h2db
conda install numpy 

#metaphlan
wget https://www.dropbox.com/s/ztqr8qgbo727zpn/metaphlan2.zip?dl=0
mv metaphlan2.zip\?dl\=0 metaphlan2.zip
sudo apt-get install unzip 
unzip metaphlan2.zip 
echo "export PATH=\${PATH}:/home/ubuntu/metaphlan2" >> $HOME/.bashrc

#conda 
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh

#entrez direct
conda config --add channels bioconda
conda install entrez-direct

#sra toolkit
wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.0/sratoolkit.2.9.0-ubuntu64.tar.gz
echo "export PATH=\${PATH}:/home/ubuntu/metaphlan2" >> $HOME/.bashrc

#aws
sudo apt-get install awscli
