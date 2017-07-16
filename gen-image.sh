#!/bin/bash
echo 'deb [arch=armhf] http://us-east1.gce.archive.ubuntu.com/ubuntu/ trusty main restricted' >> /etc/apt/sources.list
cat /etc/apt/sources.list
sudo apt-get update -y
sudo apt-get install -y crossbuild-essential-armhf
