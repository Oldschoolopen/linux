# ------------------------------------------------------------------------------
# install web server for ubuntu 18.04 bionic
# nginx 1.14.0 or apache2 2.4.29, with default php7.2
# ------------------------------------------------------------------------------

menu_webserver() {
	HTTP_SERVER="${1:-${HTTP_SERVER}}"
	TARGET="${2:-${TARGET}}"

	# abort if the system is not set up properly
	done_deps || return

	# install webserver (nginx or apache2)
	if [ "${HTTP_SERVER}" = "nginx" ]; then
		install_nginx
		install_phpfpm_nginx				# php-fpm for all targets
	else
		HTTP_SERVER="apache2"
		install_apache2
		if [ "${TARGET}" = "ispconfig" ]; then
			install_phpfpm_apache2			# php-fpm for ispconfig
		else
			install_modphp_apache2			# mod-php for other targets
		fi;
	fi;

	install_adminer
	install_sslcert_selfsigned
}	# end menu_webserver
