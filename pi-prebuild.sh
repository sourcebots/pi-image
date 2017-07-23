#!/bin/bash

set -e

echo "Hello!"
uname -a

export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none

echo "Adding backports"
echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
mkdir -p ~/.gnupg
gpg --keyserver subkeys.pgp.net --recv-keys 7638D0442B90D010
gpg -a --export 7638D0442B90D010 | apt-key add -

echo "Updating apt"
apt-get update -y

echo "Upgrading anything out of date"
apt-get upgrade -y
apt-get dist-upgrade -y

echo "Installing git"
apt-get install -y git

echo "Installing build tools"
apt-get install -y build-essential devscripts debhelper dh-systemd

