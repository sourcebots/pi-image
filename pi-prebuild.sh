#!/bin/bash

set -e

echo "Hello!"
uname -a

export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none

echo "Updating apt"
apt-get --quiet update -y

echo "Upgrading anything out of date"
apt-get --quiet upgrade -y
apt-get --quiet dist-upgrade -y

echo "Installing git"
apt-get --quiet install -y git

echo "Installing build tools"
apt-get --quiet install -y build-essential devscripts debhelper dh-systemd

echo "Installing some useful cached bits for downstream builds"
apt-get --quiet install -y \
    libopencv-core-dev \
    libopencv-contrib-dev \
    libopencv-video-dev \
    libopencv-photo-dev \
    python3-dev \
    python3-cffi

echo "Install some useful tools for debugging"
apt-get --quiet install -y \
    ipython3 \
    htop \
    python3-pip \
    screen \
    vim

echo "Rebuilding locale"
echo "en_GB.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen
dpkg-reconfigure locales || true
