#!/bin/bash
IMAGE=https://downloads.raspberrypi.org/raspbian_latest

set -e

if [ -f raspbian.zip ]; then
    echo "Image already downloaded."
    exit 0
fi

echo "Downloading Raspbian image"
curl -L $IMAGE -o raspbian.zip
unzip raspbian.zip
ls *

