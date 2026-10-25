#!/bin/sh
# Builds the Brave OS ISO. Run as root on Debian 13 (or in a debian:trixie
# container with --privileged). Needs live-build, debootstrap, xorriso,
# squashfs-tools, mtools, dosfstools, isolinux, syslinux-common,
# grub-pc-bin, grub-efi-amd64-bin.
set -eu

[ "$(id -u)" -eq 0 ] || { echo "Run as root: sudo sh host-tools/build.sh" >&2; exit 1; }
command -v lb >/dev/null 2>&1 || { echo "live-build is not installed: apt-get install live-build" >&2; exit 1; }

here=$(cd "$(dirname "$0")/.." && pwd)
cd "$here/image"

lb clean || true
lb config
lb build 2>&1 | tee build.log

iso=$(ls -1 ./*.iso 2>/dev/null | head -n 1 || true)
[ -n "$iso" ] || { echo "No ISO was produced; see image/build.log" >&2; exit 1; }
sha256sum "$iso" > "$iso.sha256"
echo "Built: $here/image/$iso"
cat "$iso.sha256"
