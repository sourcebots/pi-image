#!/bin/bash

# Serial: 2

TARGET=${1:-raspbian.zip}
# Note: if updating the image we're using, you should also update the hash
# below. The hashes are available from Raspberry Pi as "$IMAGE.sha256".
IMAGE=https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-12-01/2017-11-29-raspbian-stretch-lite.zip

echo "e942b70072f2e83c446b9de6f202eb8f9692c06e7d92c343361340cc016e0c9f $TARGET" > sha256

# If we already have the file, and it's got the right hash, then skip the download
sha256sum --check sha256 && echo "Image already downloaded." && exit 0

set -e

echo "Downloading Raspbian image"
curl -L $IMAGE -o $TARGET

sha256sum --check sha256
