#!/bin/sh
# Static checks on the kit. These do not prove the image boots.
cd "$(dirname "$0")/.." || exit 1
inc=image/config/includes.chroot
fail=0

check() { # description, command...
	d=$1; shift
	if "$@" >/dev/null 2>&1; then echo "ok    $d"; else echo "FAIL  $d"; fail=1; fi
}

for f in $inc/usr/local/bin/* $inc/etc/profile.d/*.sh image/auto/config \
	image/config/hooks/live/*.chroot image/config/hooks/live/*.hook.binary host-tools/*.sh; do
	check "sh -n $f" sh -n "$f"
done
for f in $inc/etc/xdg/labwc/menu.xml $inc/etc/xdg/labwc/rc.xml; do
	command -v xmllint >/dev/null 2>&1 && check "xmllint $f" xmllint --noout "$f"
done
command -v jq >/dev/null 2>&1 && check "jq policy" jq . $inc/etc/brave/policies/managed/brave-os.json
command -v nft >/dev/null 2>&1 && check "nft -c" nft -c -f $inc/etc/nftables.conf
if command -v shellcheck >/dev/null 2>&1; then
	check "shellcheck" shellcheck -s sh $inc/usr/local/bin/* host-tools/*.sh
fi
exit $fail
