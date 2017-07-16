#!/bin/bash
set -e

find /etc/apt/sources.list.d -exec sed -i 's/^deb\([^ ]*\) /deb\1 [arch=amd64] /' '{}' ';'
sed -i 's/^deb\([^ ]*\) /deb\1 [arch=amd64] /' /etc/apt/sources.list

echo 'deb [arch=armhf] http://ports.ubuntu.com/ trusty main restricted' >> /etc/apt/sources.list
echo 'deb-src [arch=armhf] http://ports.ubuntu.com/ trusty main restricted' >> /etc/apt/sources.list
cat /etc/apt/sources.list
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys A4A9406876FCBD3C456770C88C718D3B5072E1F5
sudo dpkg --add-architecture armhf
sudo apt-get update -y
sudo apt-get install -y crossbuild-essential-armhf
