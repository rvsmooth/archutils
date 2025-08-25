#!/bin/bash
set -e

ROOT="$1"
BOOT="$2"

error_out() {
  echo "Error: $1"
  exit 1
}

if [[ ! -n "$ROOT" ]]; then
  echo "Disks are not selected."
  echo "===================FOR UEFI========================="
  echo "usage: ./btrfs.sh <root_disk> <boot_disk>"
  echo "usage: curl -fsSL btrfs.sh | bash -s -- <root_disk> <boot_disk>"
  echo "example: curl -fsSL btrfs.sh | bash -s -- sda2 sda1"
  echo ""
  echo "==================FOR MSDOS========================="
  echo "usage: ./btrfs.sh <root_disk>"
  echo "usage: curl -fsSL btrfs.sh | bash -s -- <root_disk>"
  echo "example: curl -fsSL btrfs.sh | bash -s -- sda2"
  exit 1
fi

mount /dev/"$ROOT" /mnt || { error_out "Failed to mount /dev/$ROOT to /mnt"; }

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var_log
btrfs subvolume create /mnt/@var_cache
btrfs subvolume create /mnt/@var_waydroid
btrfs subvolume create /mnt/@var_libvirt
btrfs subvolume create /mnt/@snapshots

umount -R /mnt || { error_out "Failed to umount /mnt"; }

mount -o compress=zstd,noatime,subvol=@ /dev/"$ROOT" /mnt/ || { error_out "Failed to mount @ subvolume as /mnt"; }
mkdir -p /mnt/{home,var/log,var/cache/pacman/pkg,.snapshots,boot,var/lib/waydroid,var/lib/libvirt}

mount -o compress=zstd,noatime,subvol=@home /dev/"$ROOT" /mnt/home
mount -o compress=zstd,noatime,subvol=@var_log /dev/"$ROOT" /mnt/var/log
mount -o compress=zstd,noatime,subvol=@var_cache /dev/"$ROOT" /mnt/var/cache/pacman/pkg
mount -o compress=zstd,noatime,subvol=@var_waydroid /dev/"$ROOT" /mnt/var/lib/waydroid
mount -o compress=zstd,noatime,subvol=@var_libvirt /dev/"$ROOT" /mnt/var/lib/libvirt
mount -o compress=zstd,noatime,subvol=@snapshots /dev/"$ROOT" /mnt/.snapshots

if [[ -n "$BOOT" ]]; then
  echo "$BOOT is provided"
  echo "Mounting $BOOT as /mnt/boot"
  mount /dev/"$BOOT" /mnt/boot || { error_out "Failed to mount /dev/$BOOT as /boot"; }
elif [[ ! -n "$BOOT" ]]; then
  echo "BOOT partition is not provided"
  echo "Assuming MSDOS installation"
else
  echo "$BOOT is unrecognized"
fi
