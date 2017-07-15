#!/bin/bash
IMAGE=https://downloads.raspberrypi.org/raspbian_latest

set -e
echo "Downloading Raspbian image"
curl -L $IMAGE -o raspbian.zip
unzip raspbian.zip
ls *

