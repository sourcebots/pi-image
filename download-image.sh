#!/bin/bash

# Serial: 2

TARGET=${1:-raspbian.zip}
# Note: if updating the image we're using, you should also update the hash
# below. The hashes are available from Raspberry Pi as "$IMAGE.sha256".
IMAGE=https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2019-06-24/2019-06-20-raspbian-buster-lite.zip

echo "9009409a9f969b117602d85d992d90563f181a904bc3812bdd880fc493185234 $TARGET" > sha256

# If we already have the file, and it's got the right hash, then skip the download
sha256sum --check sha256 && echo "Image already downloaded." && exit 0

set -e

echo "Downloading Raspbian image"
curl -L $IMAGE -o $TARGET

sha256sum --check sha256
