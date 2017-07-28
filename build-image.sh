#!/bin/bash

set -e

cp /tmp/raspbian-base.img ./raspbian-base.img
IMAGE=raspbian-base.img
TARGET=raspbian-base

sha1sum $IMAGE

rmdir $TARGET || true
mkdir $TARGET
kpartx -av $IMAGE
mount /dev/mapper/loop0p2 $TARGET

mount --bind /proc $TARGET/proc
mount --bind /dev $TARGET/dev

mkdir $TARGET/building
mount --bind $(pwd)/components $TARGET/building

cp /usr/bin/qemu-arm-static $TARGET/usr/bin/qemu-arm-static
cp pi-main.sh $TARGET/main.sh
# Disable ld preload
mv $TARGET/etc/ld.so.preload ./ld.so.preload

chroot $TARGET /main.sh

echo "Cleaning up: Removing drive scripts"

rm $TARGET/main.sh
rm $TARGET/usr/bin/qemu-arm-static
mv ./ld.so.preload $TARGET/etc/ld.so.preload

echo "Dropping bind mounts"
umount $TARGET/proc
umount $TARGET/dev
umount $TARGET/building
rmdir $TARGET/building

echo "Clearing out leftover users"
sleep 2

lsof $TARGET
fuser -k -TERM $TARGET || true
sleep 2
fuser -k -KILL $TARGET || true

echo "Unmounting target"
umount $TARGET
sync

echo "Dropping loop devices"
kpartx -d $IMAGE

sha1sum $IMAGE

cp $IMAGE pi-image.img
