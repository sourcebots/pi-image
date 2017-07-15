#!/bin/bash
IMAGE=https://downloads.raspberrypi.org/raspbian_latest

echo "Updating apt"
sudo apt-get update

echo "Installing dependencies"
sudo apt-get install curl

set -e
echo "Downloading Raspbian image"
curl -L $IMAGE -o raspbian.zip
unzip raspbian.zip
ls *

