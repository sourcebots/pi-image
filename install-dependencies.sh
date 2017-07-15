#!/bin/sh

set -e
echo "Updating apt"
sudo apt-get update

echo "Installing dependencies"
sudo apt-get install curl

