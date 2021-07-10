# ------------------------------------------------------------------------------
# install PHP-FPM for nginx (default 7.3 + other version) for debian 10 buster
# https://dev.to/pushkaranand/upgrading-to-php-7-4-26dg
# ------------------------------------------------------------------------------

install_phpfpm_nginx() {
	local V=7.4

	# abort if package was already installed
	is_installed "php${V}-fpm" && {
		Msg.warn "PHP${V} as PHP-FPM is already installed..."
		return
	}

	# add external repository for updated php
	add_php_repository

	# now install php packages, + versions 7.4, with some modules
	pkg_install php7.3 \
		php7.3-{apcu,apcu-bc,bcmath,bz2,cgi,cli,curl,fpm,gd,gmp,imap,intl,ldap,mbstring,mysql,pspell,recode,soap,sqlite3,tidy,xmlrpc,xsl,zip} \
		php${V} \
		php${V}-{apcu,apcu-bc,bcmath,bz2,cgi,cli,curl,fpm,gd,gmp,imap,intl,ldap,mbstring,mysql,pspell,soap,sqlite3,tidy,xmlrpc,xsl,zip} \
		php-{gettext,imagick,pear} imagemagick bzip2 mcrypt
#		php7.4-{cgi,cli,curl,fpm,gd,imap,intl,mbstring,mysql,pspell,recode,soap,sqlite3,tidy,xmlrpc,xsl,zip} \
#		php-{memcache,memcached} memcached \

	# set alternative for php in cli mode
	cmd update-alternatives --auto php
#	cmd update-alternatives --set php /usr/bin/php${V}

	Msg.info "Configuring PHP for nginx..."
	cd /etc/nginx

	# adjust date.timezone in all php.ini
	sed -ri "s|^;(date\.timezone =).*|\1 '${TIME_ZONE}'|" /etc/php/*/*/php.ini

	# cgi.fix_pathinfo provides *real* PATH_INFO/PATH_TRANSLATED support for CGI
	sed -ri 's|^;(cgi.fix_pathinfo).*|\1 = 0|' /etc/php/*/fpm/php.ini

	cmd systemctl restart nginx
	Msg.info "Installation of PHP${V} as PHP-FPM completed!"
}	# end install_phpfpm_nginx
