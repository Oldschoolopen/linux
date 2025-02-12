# ------------------------------------------------------------------------------
# install mailserver postfix 3.3.0 for for ubuntu 18.04 bionic
# https://reposcope.com/package/postfix
# ------------------------------------------------------------------------------

install_postfix() {
	Pkg.installed "postfix-mysql" && {
		Msg.warn "Postfix is already installed..."
		return
	}

	# install postfix & saslauthd, this add openssl ssl-cert
	Msg.info "Installing postfix..."

	# preseed postfix
	debconf-set-selections <<EOF
postfix postfix/main_mailer_type select Internet Site
postfix postfix/mailname string ${MAIL_NAME}
postfix postfix/destinations string \$myorigin,localhost
EOF

	# install required & useful packages
	pkg_install postfix postfix-mysql libsasl2-modules pfqueue swaks

	Msg.info "Configuring Postfix for generic use..."

	# set basic parameters in main.cf
	cmd postconf \
		myhostname=${MAIL_NAME} \
		myorigin=\$myhostname \
		mydestination=\$myorigin,localhost

	# install /etc/aliases
	copy_to /etc postfix/aliases
	sed -i "s|ROOT_MAIL|${ROOT_MAIL}|" /etc/aliases
	cmd newaliases

	# activating ports on firewall
	firewall_allow "ssltls"

	Msg.info "Installation of postfix & aliases completed!"
}	# end install_postfix
