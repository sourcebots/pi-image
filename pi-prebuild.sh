#!/bin/bash

set -e

echo "Hello!"
uname -a

echo "Updating apt"
apt-get update -y

echo "Upgrading anything out of date"
apt-get upgrade -y
apt-get dist-upgrade -y

echo "Upgrade to Debian Stretch"
sed -i 's/jessie/stretch/g' /etc/apt/sources.list
DEBIAN_FRONTEND=noninteractive APT_LISTCHANGES_FRONTEND=mail apt-get update -y --force-yes
DEBIAN_FRONTEND=noninteractive APT_LISTCHANGES_FRONTEND=mail apt-get upgrade -y --force-yes
DEBIAN_FRONTEND=noninteractive APT_LISTCHANGES_FRONTEND=mail apt-get dist-upgrade -y --force-yes

echo "Installing git"
apt-get install -y git

echo "Installing build tools"
apt-get install -y build-essential devscripts debhelper dh-systemd

