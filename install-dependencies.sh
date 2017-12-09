#!/bin/bash

set -e
echo "Updating apt"
apt-get update

function canhas {
    DEBIAN_FRONTEND=noninteractive apt-get -y install $1
}

echo "Installing dependencies"
canhas curl
canhas unzip
canhas kpartx
canhas qemu
canhas binfmt-support
canhas qemu-user-static
canhas git
