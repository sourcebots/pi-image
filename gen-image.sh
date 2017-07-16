#!/bin/bash
set -e
echo 'deb [arch=armhf] http://ports.ubuntu.com/ trusty main restricted' >> /etc/apt/sources.list
echo 'deb-src [arch=armhf] http://ports.ubuntu.com/ trusty main restricted' >> /etc/apt/sources.list
cat /etc/apt/sources.list
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys A4A9406876FCBD3C456770C88C718D3B5072E1F5
sudo apt-get update -y
sudo apt-get install -y crossbuild-essential-armhf
sudo dpkg --add-architecture armhf
