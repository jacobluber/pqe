#!/bin/bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install pip
pip install humann2
mkdir h2db 
humann2_databases --download chocophlan full /home/ubuntu/h2db

