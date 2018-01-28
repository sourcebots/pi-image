#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"

echo "Putting hostname into /etc/hosts"
echo "127.0.0.1	$(hostname)" >> /etc/hosts

echo "Disable dhcpcd"
systemctl disable dhcpcd.service

mkdir sb-debs

echo "Adding local repository to sources"
echo "deb [trusted=yes] file:/sb-debs ./" >> /etc/apt/sources.list.d/sourcebots.list
echo "deb-src [trusted=yes] file:/sb-debs ./" >> /etc/apt/sources.list.d/sourcebots.list

function rebuild_repo {
    pushd /sb-debs
    echo "Rebuilding local apt repository"
    dpkg-scanpackages . /dev/null > Packages
    xz -f -3 Packages
    dpkg-scansources . /dev/null > Sources
    xz -f -3 Sources
    popd
}

rebuild_repo

cd /building

function buildme {
    pushd $1
    echo "Installing build dependencies for $1"
    yes | sudo mk-build-deps -i debian/control

    echo "Building $1"
    DEB_BUILD_OPTIONS=nocheck debuild -uc -us
    popd

    mv *.deb /sb-debs/
    mv *.tar.* /sb-debs/

    rebuild_repo

    echo "Re-updating apt"
    apt-get update -y

    echo "Installing $1"
    apt-get -o "Dpkg::Options::=--force-confnew" install -y $1 || true
}

buildme usbmount
buildme sb-vision
buildme robotd
buildme robot-api
buildme runusb

echo "Setting passwords"
echo 'root:beeeeees' | chpasswd
echo 'pi:beeeeees' | chpasswd

echo "Updating fstab"
tee /etc/fstab <<EOF
proc	/proc	proc	defaults	0	0
/dev/mmcblk0p1	/boot	vfat	defaults	0	2
/dev/mmcblk0p2	/	ext4	defaults,noatime	0	1
EOF

echo "Installing additional libraries"
apt-get install -y \
    python3-scipy \
    python3-numpy

