#!/bin/bash

TARGET=${1:-raspbian.zip}
IMAGE=https://downloads.raspberrypi.org/raspbian_lite_latest

set -e

if [ -f $TARGET ]; then
    echo "Image already downloaded."
    exit 0
fi

echo "Downloading Raspbian image"
curl -L $IMAGE -o $TARGET

