#!/bin/bash

# Serial: 2

TARGET=${1:-raspbian.zip}
# Note: if updating the image we're using, you should also update the hash
# below. The hashes are available from Raspberry Pi as "$IMAGE.sha256".
IMAGE=https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-09-08/2017-09-07-raspbian-stretch-lite.zip

echo "bd2c04b94154c9804cc1f3069d15e984c927b750056dd86b9d86a0ad4be97f12 $TARGET" > sha256

# If we already have the file, and it's got the right hash, then skip the download
sha256sum --check sha256 && echo "Image already downloaded." && exit 0

set -e

echo "Downloading Raspbian image"
curl -L $IMAGE -o $TARGET

sha256sum --check sha256
