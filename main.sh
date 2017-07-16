#!/bin/bash

set -e

echo "Hello!"
uname -a

echo "Updating apt"
apt-get update -y

echo "Upgrading anything out of date"
apt-get upgrade -y

echo "Installing git"
apt-get install -y git

echo "Installing build tools"
apt-get install -y build-essential devscripts debhelper dh-systemd

mkdir sb-debs

mkdir building
cd building

function buildme {
    mkdir build-$2
    pushd build-$2
    git clone --depth 1 $1 build-$2/$2
    pushd $2
    echo "Installing build dependencies for $2"
    yes | sudo mk-build-deps -i
    echo "Building $2"
    debuild -uc -us
    popd
    mv *.deb /sb-debs/
    mv *.tar.gz /sb-debs/
    popd
}

buildme https://github.com/sourcebots/automount automount
#buildme https://github.com/sourcebots/robotd robotd

cd ..
rm -rf building

echo "Constructing local apt repository"
cd /sb-debs
dpkg-scanpackages . /dev/null > Packages
xz -9 Packages
dpkg-scansources . /dev/null > Sources
xz -9 Sources

echo "Adding local repository to sources"
echo "deb file:/sb-debs ./" >> /etc/apt/sources.list
echo "deb-src file:/sb-debs ./" >> /etc/apt/sources.list

echo "Re-updating apt"
apt-get update -y

echo "Installing local packages"
apt-get install -y automount
