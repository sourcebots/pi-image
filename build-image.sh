#!/bin/bash

set -e

unzip raspbian.zip
IMAGE=$(ls *-raspbian-*.img)

mkdir raspbian-base
kpartx -av $IMAGE
mount /dev/mapper/loop0p2 raspbian-base
ls raspbian-base
