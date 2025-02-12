# ------------------------------------------------------------------------------
# install bind9 DNS server 9.10.3 for debian 9 stretch
# https://reposcope.com/package/bind9
# ------------------------------------------------------------------------------

menu_dns() {
	if Pkg.installed "bind9"; then
		Msg.warn "DNS server bind9 is already installed..."
		return
	fi;

	# abort if the system is not set up properly
	done_deps || return

	# install the DNS server
	Msg.info "Installing DNS server bind9..."

	pkg_install bind9 dnsutils
	touch /var/log/bind9-query.log
	chown bind:0 /var/log/bind9-query.log
	copy_to ~ getSlaveZones.sh

	# activating ports on firewall
	firewall_allow "dns"

	Msg.info "Installation of DNS server bind9 completed!"
}	# end menu_dns
