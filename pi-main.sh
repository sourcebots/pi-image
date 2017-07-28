#!/bin/bash

set -e

export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"

echo "Putting hostname into /etc/hosts"
echo "127.0.0.1	$(hostname)" >> /etc/hosts

echo "Installing bits and pieces from backports"

apt-get -t jessie-backports install -y python3-cffi

mkdir sb-debs
mkdir building

echo "Adding local repository to sources"
echo "deb [trusted=yes] file:/sb-debs ./" >> /etc/apt/sources.list
echo "deb-src [trusted=yes] file:/sb-debs ./" >> /etc/apt/sources.list

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

function buildme {
    pushd building
    mkdir build-$2
    pushd build-$2
    git clone $1 $2
    echo "...clone is done"
    ls -l
    pushd $2
    echo "Installing build dependencies for $2"
    yes | sudo mk-build-deps -i debian/control
    echo "Building $2"
    debuild -uc -us
    popd
    ls
    mv *.deb /sb-debs/
    mv *.tar.* /sb-debs/
    popd
    popd

    rebuild_repo

    echo "Re-updating apt"
    apt-get update -y

    echo "Installing $2"
    apt-get install -y $2
}

buildme https://github.com/sourcebots/sb-vision sb-vision
buildme https://github.com/sourcebots/robotd robotd
buildme https://github.com/sourcebots/runusb runusb

rm -rf building
