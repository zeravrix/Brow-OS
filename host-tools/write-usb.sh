#!/bin/sh
# Writes the Brave OS ISO to a USB stick on Linux. ERASES the target device.
# Usage: sudo sh host-tools/write-usb.sh brave-os-amd64.hybrid.iso /dev/sdX
set -eu

[ "$(id -u)" -eq 0 ] || { echo "Run as root." >&2; exit 1; }
[ $# -eq 2 ] || { echo "Usage: $0 image.iso /dev/sdX" >&2; exit 1; }
iso=$1
dev=$2

[ -f "$iso" ] || { echo "No such file: $iso" >&2; exit 1; }
[ -b "$dev" ] || { echo "Not a block device: $dev" >&2; exit 1; }
case "$dev" in
	*[0-9]) echo "Give the whole device (like /dev/sdb), not a partition." >&2; exit 1 ;;
esac

name=$(basename "$dev")
removable=$(cat "/sys/block/$name/removable" 2>/dev/null || echo 0)
if [ "$removable" != "1" ]; then
	echo "WARNING: $dev is not marked removable. It may be an internal disk."
fi
lsblk -o NAME,SIZE,MODEL,TRAN,MOUNTPOINTS "$dev"
printf 'Type the device name again (%s) to erase it and continue: ' "$dev"
read -r answer
[ "$answer" = "$dev" ] || { echo "Cancelled."; exit 1; }

umount "$dev"?* 2>/dev/null || true
dd if="$iso" of="$dev" bs=4M conv=fsync status=progress
sync
echo "Done. You can remove the USB stick."
