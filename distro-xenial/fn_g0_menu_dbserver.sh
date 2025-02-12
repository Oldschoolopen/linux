# ------------------------------------------------------------------------------
# install the database server
# ------------------------------------------------------------------------------

menu_dbserver() {
	TARGET="${1:-${TARGET}}"

	# verify that the system was set up properly
	done_deps || return

	# save the root password of the DB in ~/.my.cnf
	# it also set the variable DB_ROOTPW
	[ -n "${DB_ROOTPW}" ] || db_root_pw

	# install the database server (mariadb)
	cmd install_server_mariadb
}	# end menu_dbserver
