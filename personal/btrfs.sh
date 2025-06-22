#!/bin/bash
mount /dev/$1 /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var_log
btrfs subvolume create /mnt/@var_cache
btrfs subvolume create /mnt/@var_waydroid
btrfs subvolume create /mnt/@var_libvirt
btrfs subvolume create /mnt/@snapshots

umount /mnt

mount -o compress=zstd,noatime,subvol=@ /dev/$1 /mnt/

mkdir -p /mnt/home /mnt/var/log /mnt/var/cache/pacman/pkg /mnt/.snapshots /mnt/boot /mnt/var/lib/waydroid /mnt/var/lib/libvirt

mount -o compress=zstd,noatime,subvol=@home /dev/$1 /mnt/home
mount -o compress=zstd,noatime,subvol=@var_log /dev/$1 /mnt/var/log
mount -o compress=zstd,noatime,subvol=@var_cache /dev/$1 /mnt/var/cache/pacman/pkg
mount -o compress=zstd,noatime,subvol=@var_waydroid /dev/$1 /mnt/var/lib/waydroid
mount -o compress=zstd,noatime,subvol=@var_libvirt /dev/$1 /mnt/var/lib/libvirt
mount -o compress=zstd,noatime,subvol=@snapshots /dev/$1 /mnt/.snapshots

mount /dev/$2 /mnt/boot
