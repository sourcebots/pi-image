#!/bin/bash
set -e

#rm -rf /etc/apt/sources.list.d
##find /etc/apt/sources.list.d -exec sed -i 's/^deb\([^ ]*\) /deb\1 [arch=amd64] /' '{}' ';'
#sed -i 's/^deb\([^ ]*\) /deb\1 [arch=amd64] /' /etc/apt/sources.list
#
#echo 'deb [arch=armhf] http://ports.ubuntu.com/ trusty main restricted' >> /etc/apt/sources.list
#echo 'deb-src [arch=armhf] http://ports.ubuntu.com/ trusty main restricted' >> /etc/apt/sources.list
#cat /etc/apt/sources.list
#
#sudo apt-key adv --keyserver pgp.mit.edu --recv-keys A4A9406876FCBD3C456770C88C718D3B5072E1F5
#sudo dpkg --add-architecture armhf
#sudo apt-get update -y
#sudo apt-get install -y crossbuild-essential-armhf

echo 'deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb-src http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse' >> /etc/apt/sources.list

sudo apt-get update -y
sudo apt-get install -y qemu-user-static debootstrap debian-archive-keyring bmap-tools whois gcc-arm-linux-gnueabihf

export RPI_MODEL=3
export RELEASE=stretch
export HOSTNAME=sb
export PASSWORD=beeeeees
export USER_PASSWORD=beeeeees
export DEFLOCAL=en_GB.UTF-8
export TIMEZONE=Europe/London
export ENABLE_DHCP=false
export ENABLE_NONFREE=true
export ENABLE_WIRELESS=true
export ENABLE_REDUCE=true
export ENABLE_ROOT=true
export BUILD_KERNEL=true
export ENABLE_INITRAMFS=true
export ENABLE_IFNAMES=false
export IMAGE_NAME=$(pwd)/pi-image.img

sudo dpkg -i 'debootstrap_1.0.90~bpo9+1_all.deb'

# TODO: copy in some build things

cd rpi23-gen-image

# Don't install the cross-compile tool
sed -i 's/crossbuild-essential-armhf/gcc-arm-linux-gnueabihf/' ./rpi23-gen-image.sh
sed -i 's/dist-upgrade/--allow-unauthenticated dist-upgrade/' ./bootstrap.d/11-apt.sh
exec ./rpi23-gen-image.sh
