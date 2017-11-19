#!/bin/bash

set -e

echo "Hello!"
uname -a

export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none

echo "Adding backports"
echo "deb [trusted=yes] http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

echo "Updating apt"
apt-get update -y

echo "Upgrading anything out of date"
apt-get upgrade -y
apt-get dist-upgrade -y

echo "Installing git"
apt-get install -y git

echo "Installing build tools"
apt-get install -y build-essential devscripts debhelper dh-systemd

echo "Installing some useful cached bits for downstream builds"
apt-get install -y \
    libopencv-core-dev \
    libopencv-contrib-dev \
    libopencv-video-dev \
    libopencv-photo-dev \
    python3-dev

echo "Install some useful tools for debugging"
apt-get install -y \
    ipython3\
    htop \
    screen \
    vim

echo "Rebuilding locale"
locale-gen en_US en_US.UTF-8
locale-gen en_GB en_GB.UTF-8
dpkg-reconfigure locales
