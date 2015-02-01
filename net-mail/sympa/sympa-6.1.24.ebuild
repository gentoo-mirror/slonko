# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils user depend.apache multilib autotools versionator

SYMPA_VERSION="$(get_version_component_range 1-2)"
SYMPA_RELEASE="$(get_version_component_range 3-)"

if [[ ${SYMPA_VERSION} == "9999" ]] ; then
	# Development version
	ESVN_REPO_URI="http://svn.cru.fr/sympa/trunk"
	inherit subversion
elif [[ ${SYMPA_RELEASE} == "9999" ]] ; then
	# Latest stable
	ESVN_REPO_URI="http://svn.cru.fr/sympa/branches/sympa-${SYMPA_VERSION}-branch"
	inherit subversion
else
	# Release
	SRC_URI="http://www.sympa.org/distribution/${P}.tar.gz http://www.sympa.org/distribution/old/${P}.tar.gz"
fi

DESCRIPTION="A feature-rich open source mailing list software"
HOMEPAGE="http://www.sympa.org/features.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="apache2 clamav -compat dkim fastcgi ldap mysql nfs nls postgres soap sqlite ssl"
REQUIRED_USE="|| ( mysql postgres sqlite )"

# See http://www.sympa.org/manual/installing-sympa#required_cpan_modules
RDEPEND="
	${DEPEND_APACHE}
	>=dev-lang/perl-5.8
	>=virtual/perl-CGI-3.35
	>=virtual/perl-DB_File-1.75
	>=virtual/perl-Digest-MD5-2.00
	virtual/perl-Encode
	>=virtual/perl-MIME-Base64-3.03
	>=virtual/perl-Time-HiRes-1.29
	virtual/perl-libnet
	>=dev-perl/Archive-Zip-1.05
	dev-perl/Data-Password
	>=dev-perl/DBI-1.48
	>=dev-perl/File-Copy-Recursive-0.36
	dev-perl/HTML-Format
	>=dev-perl/HTML-StripScripts-Parser-1.03
	dev-perl/HTML-Tree
	dev-perl/IO-stringy
	>=dev-perl/MIME-Charset-1.006.2
	>=dev-perl/MIME-EncWords-1.010
	>=dev-perl/MIME-Lite-HTML-1.23
	>=dev-perl/MIME-tools-5.423
	dev-perl/Net-DNS
	>=dev-perl/Net-Netmask-1.901.500
	dev-perl/Template-Toolkit
	>=dev-perl/Term-ProgressBar-2.09
	>=dev-perl/Unicode-LineBreak-2011.05
	>=dev-perl/URI-1.35
	dev-perl/XML-LibXML
	dev-perl/libintl-perl
	dev-perl/libwww-perl
	>=net-mail/mhonarc-2.6.0
	clamav? ( app-antivirus/clamav )
	compat? ( >=dev-perl/Crypt-CipherSaber-0.50 )
	dkim? ( >=dev-perl/Mail-DKIM-0.36 )
	fastcgi? ( >=dev-perl/FCGI-0.67 )
	ldap? ( >=dev-perl/perl-ldap-0.27 )
	mysql? ( >=dev-perl/DBD-mysql-4.008 )
	nfs? ( dev-perl/File-NFSLock )
	postgres? ( >=dev-perl/DBD-Pg-0.90 )
	soap? ( >=dev-perl/SOAP-Lite-0.712 )
	sqlite? ( >=dev-perl/DBD-SQLite-0.90 )
	ssl? ( >=dev-perl/IO-Socket-SSL-0.90
		dev-libs/openssl )
	virtual/mta
	"
DEPEND="${RDEPEND}
	sys-devel/gettext
	"

SYMPA_USER="sympa"
SYMPA_GROUP="sympa"

pkg_setup() {
	enewgroup ${SYMPA_GROUP}
	enewuser ${SYMPA_USER} -1 -1 -1 ${SYMPA_GROUP}
}

src_unpack() {
	if [[ ${SYMPA_VERSION} == "9999" ]] ; then
		subversion_src_unpack
	elif [[ ${SYMPA_RELEASE} == "9999" ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
		cd ${S}
	fi
	cd ${S}
	# Override defaults for certain options, so
	# Sympa won't complain about conflicting paths
	sed -i -e "/'queuebounce'/,/}/ s|'/bounce'|'/qbounce'|" src/lib/confdef.pm
	# Gentoo specific: redefine some defaults
	sed -i -e 's|^\(\s*staticdir=\).*|\1/var/spool/sympa/static_content|' \
		-e 's|^\(\s*bouncedir=\).*|\1/var/spool/sympa/bounce|' \
		-e 's|^\(\s*arcdir=\).*|\1/var/spool/sympa/arc|' \
		configure.ac
	# Do not create runtime directories
	sed -i -e 's| $(piddir) | |' Makefile.am
	eautoreconf
}

src_configure() {
	econf \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir)/sympa \
		--libexec=/usr/libexec/sympa \
		--localstatedir=/var \
		--docdir=/usr/share/doc/${P} \
		--with-localedir=/usr/share/locale \
		--sysconfdir=/etc/sympa \
		--with-confdir=/etc/sympa \
		--with-piddir=/var/run/sympa \
		--with-spooldir=/var/spool/sympa \
		--with-modulesdir=/usr/$(get_libdir)/sympa \
		--with-cgidir=/usr/libexec/sympa \
		--with-expldir=/var/lib/sympa/lists \
		--with-scriptdir=/usr/share/sympa/scripts \
		--with-initdir=/usr/share/sympa/scripts \
		--with-defaultdir=/usr/share/sympa/default \
		--with-user=${SYMPA_USER} \
		--with-group=${SYMPA_GROUP} \
		--enable-fhs \
		$(use_enable nls) \
		|| die "econf failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS} -Wl,-z,now" || die "emake failed."
}

src_install() {

	emake DESTDIR="${D}" install || die "emake install failed"

	# Do not overwrite data_structure.version
	rm -f "${D}/etc/sympa/data_structure.version"
	# Set permissions and ownership on config files
	fowners root:${SYMPA_GROUP} /etc/sympa/sympa.conf /etc/sympa/wwsympa.conf
	fperms u=rwX,g=rX,o= /etc/sympa/sympa.conf /etc/sympa/wwsympa.conf
	# Elevate some permissions to read config files
	fperms g+s /usr/libexec/sympa/{bouncequeue,familyqueue,queue}

	# Docs
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README README.charset

	# Startup script
	newinitd "${FILESDIR}/${PN}-${SYMPA_VERSION}.initd" "${PN}"

	# Set proper fastcgi flag
	if use fastcgi; then
		sed -i -r 's:^(\s*use_fast_cgi\s*).*:\11:' "${D}/etc/sympa/wwsympa.conf"
	else
		sed -i -r 's:^(\s*use_fast_cgi\s*).*:\10:' "${D}/etc/sympa/wwsympa.conf"
	fi	
	# Update antivirus config
	if use clamav; then
		sed -i -r \
			-e 's:^#?\s*antivirus_path\s*/.*:antivirus_path /usr/bin/clamscan:' \
			-e 's:^#?\s*antivirus_args\s*.*:antivirus_args --stdout:' \
			"${D}/etc/sympa/sympa.conf"
	else
		sed -i -r \
			-e 's:^(\s*antivirus_path\s*/.*):#\1:' \
			-e 's:^(\s*antivirus_args\s*.*):#\1:' \
			"${D}/etc/sympa/sympa.conf"
	fi
	# Update openssl config
	if use ssl; then
		sed -i -r \
			-e 's:^#?\s*openssl\s*/.*:openssl /usr/bin/openssl:' \
			-e 's:^#?\s*capath\s*/.*:capath /etc/ssl/certs:' \
			-e 's:^#?\s*cafile\s*/.*:cafile /etc/ssl/certs/ca-certificates.crt:' \
			"${D}/etc/sympa/sympa.conf"
	else
		sed -i -r \
			-e 's:^(\s*openssl\s*/.*):#\1:' \
			-e 's:^(\s*capath\s*/.*):#\1:' \
			-e 's:^(\s*cafile\s*/.*):#\1:' \
			"${D}/etc/sympa/sympa.conf"
	fi
	# Queue dirs
	keepdir /var/spool/sympa
	local SYMPA_DIRS="arc auth automatic bounce digest distribute expire \
		moderation msg outgoing qbounce static_content subscribe task tmp topic"
	local DIR
	for DIR in ${SYMPA_DIRS}; do
		keepdir /var/spool/sympa/${DIR}
		fowners ${SYMPA_USER}:${SYMPA_GROUP} /var/spool/sympa/${DIR}
		case "${DIR}" in
			"static_content" )
				fperms 755 /var/spool/sympa/${DIR}
			;;
			* )
				fperms 750 /var/spool/sympa/${DIR}
			;;
		esac
	done
	keepdir /var/lib/sympa
	keepdir /var/lib/sympa/lists

	newdoc "${FILESDIR}/${PN}-apache.conf" apache.conf || \
		die "newdoc failed"
	newdoc "${FILESDIR}/${PN}-apache_soap.conf" apache_soap.conf || \
		die "newdoc failed"
	newdoc "${FILESDIR}/${PN}-lighttpd.conf" lighttpd.conf ||\
		die "newdoc failed"
	newdoc "${FILESDIR}/${PN}-lighttpd_soap.conf" lighttpd_soap.conf ||\
		die "newdoc failed"
	newdoc "${FILESDIR}/${PN}-nginx.conf" nginx.conf ||\
		die "newdoc failed"
}

pkg_postinst() {
	elog
	elog "You need to create a database with associated database account"
	elog "prior to use Sympa. That account will need general"
	elog "access privileges to the Sympa database."
	elog
	elog "The Sympa web interface needs to be setup in your webserver."
	elog "For more information please consult Sympa documentation at"
	elog "http://www.sympa.org/manual/web-interface#web_server_setup"
	elog "Sample configs are installed in /usr/share/doc/${P}"
	elog

	if use clamav; then
		elog "By default we use clamscan antivirus scanner"
		elog "(antivirus_path option in sympa.conf). For performance"
		elog "reason you might want to use clamdscan which is much faster."
		elog "To use it you need to do the following:"
		elog
		elog "# gpasswd -a clamav sympa"
		elog "# /etc/init.d/clamd restart"
		elog
	fi

	ewarn "If you are upgrading from an earlier version please run:"
	ewarn
	ewarn "# sympa.pl --upgrade"
	ewarn
	ewarn "If you are upgrading from version 5.x make sure"
	ewarn "compat use flag is set while emerging, then run:"
	ewarn
	ewarn "# sympa.pl --upgrade"
	ewarn
	ewarn "to upgrade your data structures and"
	ewarn
	ewarn "# sympa.pl --md5_encode_password"
	ewarn
	ewarn "to convert your passwords. When completed compat use flag"
	ewarn "can be removed"
}
