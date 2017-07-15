#!/bin/sh

set -e
echo "Updating apt"
apt-get update

echo "Installing dependencies"
apt-get install curl

