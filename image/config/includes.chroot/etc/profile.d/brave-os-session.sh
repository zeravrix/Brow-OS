# Start the Brave OS graphical session on the first console for the browsing
# user. After three quick failures it stops and leaves a text console so the
# machine cannot loop forever.
if [ "$(id -u)" -ge 1000 ] && [ -z "${WAYLAND_DISPLAY:-}" ] && [ "$(tty 2>/dev/null)" = "/dev/tty1" ]; then
	_bos_f="/dev/shm/brave-os-labwc-starts-$(id -u)"
	_bos_n=$(cat "$_bos_f" 2>/dev/null || echo 0)
	if [ "$_bos_n" -lt 3 ]; then
		echo $((_bos_n + 1)) > "$_bos_f"
		exec labwc
	fi
	echo "Brave OS: the graphical session failed 3 times in a row."
	echo "Type 'labwc' to try again, or 'journalctl -b' to see what went wrong."
fi
