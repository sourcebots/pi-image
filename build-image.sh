#!/bin/bash

set -e

unzip raspbian.zip
IMAGE=$(ls *-raspbian-*.img)
TARGET=raspbian-base

sha1sum $IMAGE

mkdir $TARGET
kpartx -av $IMAGE
mount /dev/mapper/loop0p2 $TARGET

cp /usr/bin/qemu-arm-static $TARGET/usr/bin/qemu-arm-static
cp main.sh $TARGET/main.sh

chroot $TARGET /main.sh

rm $TARGET/main.sh
rm $TARGET/usr/bin/qemu-arm-static

umount $TARGET
sync

sha1sum $IMAGE
