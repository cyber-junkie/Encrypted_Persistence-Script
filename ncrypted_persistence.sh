#!/bin/bash

fdisk -l /dev/sdb

echo "Enter Device Name [sdb1, sdb2, etc]: "

read device_name

cryptsetup --verbose --verify-passphrase luksFormat /dev/$device_name

cryptsetup luksOpen /dev/$device_name parrot

mkfs.ext4 -L persistence /dev/mapper/parrot

e2label /dev/mapper/parrot persistence

mkdir -p /mnt/parrot

mount /dev/mapper/parrot /mnt/parrot

echo "/ union" > /mnt/parrot/persistence.conf

umount /dev/mapper/parrot