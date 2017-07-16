#!/bin/bash

set -e

mkdir sb-debs

mkdir building
cd building

function buildme {
    mkdir build-$2
    pushd build-$2
    git clone --depth 1 $1 $2
    echo "...clone is done"
    ls -l
    pushd $2
    echo "Installing build dependencies for $2"
    yes | sudo mk-build-deps -i
    echo "Building $2"
    debuild -uc -us
    popd
    ls
    mv *.deb /sb-debs/
    mv *.tar.* /sb-debs/
    popd
}

buildme https://github.com/sourcebots/automount automount
buildme https://github.com/sourcebots/robotd robotd

cd ..
rm -rf building

echo "Constructing local apt repository"
cd /sb-debs
dpkg-scanpackages . /dev/null > Packages
xz -9 Packages
dpkg-scansources . /dev/null > Sources
xz -9 Sources

echo "Adding local repository to sources"
echo "deb [trusted=yes] file:/sb-debs ./" >> /etc/apt/sources.list
echo "deb-src [trusted=yes] file:/sb-debs ./" >> /etc/apt/sources.list

echo "Re-updating apt"
apt-get update -y

echo "Installing local packages"
apt-get install -y automount || true
apt-get install -y robotd || true
