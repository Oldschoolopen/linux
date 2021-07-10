# ------------------------------------------------------------------------------
# install the AntiSpam SMTP Proxy version 1 (min 384ram 1core)
# ------------------------------------------------------------------------------

menu_assp1() {
	[ -d /home/assp ] && {
		Msg.warn "ASSP v1 is already installed..."
		return
	}

	# verify that the system was set up
	done_deps || return

	# install prerequisites
	TARGET="assp"
	CERT_OU="antispam-server"
	menu_mailserver			# mailserver: postfix & sasl2_sql
	menu_dbserver			# database server: mariadb
	menu_webserver			# webserver: apache with mod-php

	install_assp "v1"		# install ASSP version 1
}	# end menu_assp1
