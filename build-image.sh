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
# Disable ld preload
mv $TARGET/ld.so.preload ./ld.so.preload

chroot $TARGET /main.sh

rm $TARGET/main.sh
rm $TARGET/usr/bin/qemu-arm-static
mv ./ld.so.preload $TARGET/ld.so.preload

umount $TARGET
sync

sha1sum $IMAGE

cp $IMAGE pi-image.img
