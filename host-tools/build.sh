#!/usr/bin/env bash
# Build the Brow OS ISO on Debian 13 (or in the debian:trixie CI container).
set -Eeuo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Run as root: sudo bash host-tools/build.sh" >&2
  exit 1
fi
command -v lb >/dev/null 2>&1 || {
  echo "live-build is not installed: apt-get install live-build" >&2
  exit 1
}

here="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$here/image"

# Clean generated outputs first so an earlier ISO can never mask a failed build.
lb clean || true
rm -f ./*.iso ./*.iso.sha256 build.log

lb config
lb build 2>&1 | tee build.log

iso="$(find . -maxdepth 1 -type f -name '*.iso' -print -quit)"
if [[ -z "$iso" ]]; then
  echo "No ISO was produced; see image/build.log" >&2
  exit 1
fi
iso_name="${iso#./}"
# Store a filename relative to the ISO directory, not the leading "./" that
# find emits. This makes the companion checksum valid both here and from the
# repository root in CI.
sha256sum "$iso_name" > "$iso_name.sha256"
echo "Built: $here/image/$iso"
cat "$iso_name.sha256"
