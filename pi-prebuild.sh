#!/bin/bash

set -e

echo "Hello!"
uname -a

echo "Updating apt"
apt-get update -y

echo "Upgrading anything out of date"
apt-get upgrade -y

echo "Installing git"
apt-get install -y git

echo "Installing build tools"
apt-get install -y build-essential devscripts debhelper dh-systemd

