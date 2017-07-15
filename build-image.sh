#!/bin/bash

set -e

unzip raspbian.zip
IMAGE=$(ls *-raspbian-*.img)

mkdir raspbian-base
mount -o loop $IMAGE raspbian-base/
