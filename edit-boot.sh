#!/bin/bash
set -e

echo "Setting up boot mount"
TARGET_BOOT="boot-partition"
mkdir -p $TARGET_BOOT

kpartx -av pi-image.img
mount /dev/mapper/loop0p1 $TARGET_BOOT

echo 'dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait init=/sbin/init' > $TARGET_BOOT/cmdline.txt

echo "Unmounting boot"
umount $TARGET_BOOT
sync

kpartx -d pi-image.img

