#!/bin/bash

# Serial: 2

TARGET=${1:-raspbian.zip}
IMAGE=https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-12-01/2017-11-29-raspbian-stretch-lite.zip

set -e

if [ -f $TARGET ]; then
    echo "Image already downloaded."
    exit 0
fi

echo "Downloading Raspbian image"
curl -L $IMAGE -o $TARGET

