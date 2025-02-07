# ------------------------------------------------------------------------------
# cleanup OS minimizing the installed packages
# ------------------------------------------------------------------------------

menu_deps() {
	local P="${1:-${SSHD_PORT}}"

	menu_resolv

	shell_bash
	menu_tz
	OS.minimalize
	install_syslogd
	install_firewall "${P}"

	menu_motd
	menu_ssh "${P}"

	menu_resolv
}	# end menu_deps

