#!/bin/bash

set -e

echo "Hello!"
uname -a

echo "Updating apt"
apt update -y

echo "Upgrading anything out of date"
apt upgrade -y

echo "Installing git"
apt install -y git

echo "Installing build tools"
apt install -y build-essential devscripts debhelper dh-systemd

mkdir building
cd building

function buildme {
    git clone --depth 1 $1 $2
    pushd $2
    yes | sudo mk-build-deps -i
    debuild -uc -us
    popd
}

buildme https://github.com/sourcebots/automount automount
buildme https://github.com/sourcebots/robotd robotd

cd ..
rm -rf building

