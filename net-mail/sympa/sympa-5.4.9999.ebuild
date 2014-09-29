# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils depend.apache multilib autotools versionator

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
KEYWORDS=""
IUSE="mysql postgres sqlite sqlite3 apache2 clamav fastcgi ldap nfs soap ssl"

# See http://www.sympa.org/manual/installing-sympa#required_cpan_modules
RDEPEND="
	>=dev-lang/perl-5.8
	${DEPEND_APACHE}
	>=virtual/perl-CGI-3.35
	>=virtual/perl-DB_File-1.75
	>=virtual/perl-Digest-MD5-2.00
	>=virtual/perl-File-Spec-0.8
	>=virtual/perl-MIME-Base64-3.03
	virtual/perl-libnet
	>=dev-perl/Archive-Zip-1.05
	>=dev-perl/Crypt-CipherSaber-0.90
	>=dev-perl/DBI-1.48
	>=dev-perl/HTML-StripScripts-Parser-1.0
	dev-perl/IO-stringy
	>=dev-perl/MIME-Charset-0.04.1
	>=dev-perl/MIME-EncWords-0.040
	>=dev-perl/MIME-tools-5.423
	>=dev-perl/MailTools-1.51
	dev-perl/Template-Toolkit
	dev-perl/XML-LibXML
	dev-perl/libintl-perl
	dev-perl/libwww-perl
	dev-perl/regexp-common
	clamav? ( app-antivirus/clamav )
	fastcgi? ( >=dev-perl/FCGI-0.67 )
	ldap? ( >=dev-perl/perl-ldap-0.27 )
	mysql? ( >=dev-perl/DBD-mysql-2.0407 )
	>=net-mail/mhonarc-2.6.0
	nfs? ( dev-perl/File-NFSLock )
	postgres? ( >=dev-perl/DBD-Pg-0.90 )
	soap? ( >=dev-perl/SOAP-Lite-0.60 )
	sqlite? ( dev-perl/DBD-SQLite2 )
	sqlite3? ( dev-perl/DBD-SQLite )
	ssl? ( dev-perl/IO-Socket-SSL
		dev-libs/openssl )
	virtual/mta
	"
DEPEND="${RDEPEND}
	sys-devel/gettext
	"

SYMPA_USER="sympa"
SYMPA_GROUP="sympa"

# TODO
# apache2 conf ??
# DBD-Oracle ??
# DBD-Sybase ??

pkg_setup() {
	if ! ( useq mysql || useq postgres || useq sqlite || useq sqlite3 ); then
		eerror
		eerror "You have not specified any supported database backend in your USE flags"
		eerror "Supported database backends:"
		eerror "mysql, postgres, sqlite & sqlite3"
		eerror
		die "No database backend specified"
	fi
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
	fi
	cd ${S}
	# Gentoo specific
	epatch ${FILESDIR}/${PN}-${SYMPA_VERSION}.gentoo_default_config.patch
	# Ignore interactive scripts / Enable custom CFLAGS
	epatch ${FILESDIR}/${PN}-${SYMPA_VERSION}.Makefile.am.patch
	# Fix locale during initial startup
	epatch ${FILESDIR}/${PN}-${SYMPA_VERSION}.locale.patch
	# Fix moderation lefovers
	epatch ${FILESDIR}/${PN}-${SYMPA_VERSION}.moderation.patch
	eautoreconf
}

src_compile() {
	local myconf=""

	# No effect
	# useq ssl && myconf="${myconf} --with-openssl=/usr/bin/openssl"

	econf \
		--prefix=/usr \
		--with-sbindir=/usr/sbin \
		--with-spooldir=/var/spool/sympa \
		--with-confdir=/etc/sympa \
		--with-etcdir=/etc/sympa \
		--with-cgidir=/usr/libexec/sympa \
		--with-datadir=/usr/share/sympa \
		--with-expldir=/var/lib/sympa/lists \
		--with-libdir=/usr/$(get_libdir)/sympa \
		--with-scriptdir=/usr/share/sympa/scripts \
		--with-initdir=/usr/share/sympa/scripts \
		--with-sampledir=/usr/share/doc/${P}/example \
		--with-piddir=/var/run/sympa \
		--with-mandir=/usr/share/man \
		--with-docdir=/usr/share/doc/${P} \
		--with-localedir=/usr/share/locale \
		${myconf} \
		|| die "econf failed"
	emake CFLAGS="${CFLAGS} -Wl,-z,now" || die "emake failed."
}

src_install() {

	# Pre-copy existing configs so they can be updated by Sympa install procedure
	insinto /etc/sympa
	[[ -f "/etc/sympa/sympa.conf" ]] && doins /etc/sympa/sympa.conf
	[[ -f "/etc/sympa/wwsympa.conf" ]] && doins /etc/sympa/wwsympa.conf
	emake DESTDIR="${D}" install || die "emake install failed"
	
	# Set permissions and ownership on config dir
	fowners -R root:${SYMPA_GROUP} /etc/sympa
	fperms -R u=rwX,g=rX,o= /etc/sympa
	# Elevate some permissions to read config files
	fperms g+s /usr/bin/{bouncequeue,familyqueue,queue}

	# Docs
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

	# Startup script
	newinitd ${FILESDIR}/${PN}-${SYMPA_VERSION}.initd ${PN}

	# Create pidfile dir
	keepdir /var/run/sympa
	fowners ${SYMPA_USER}:${SYMPA_GROUP} /var/run/sympa

	# Set proper fastcgi flag
	if useq fastcgi; then
		sed -i -r "s:^(\s*use_fast_cgi\s*).*:\11:" ${D}/etc/sympa/wwsympa.conf
	else
		sed -i -r "s:^(\s*use_fast_cgi\s*).*:\10:" ${D}/etc/sympa/wwsympa.conf
	fi	
	# Update antivirus config
	if useq clamav; then
		sed -i -r \
			-e 's:^#?\s*antivirus_path\s*/.*:antivirus_path /usr/bin/clamscan:' \
			-e 's:^#?\s*antivirus_args\s*.*:antivirus_args --stdout:' \
			${D}/etc/sympa/sympa.conf
	else
		sed -i -r \
			-e 's:^(\s*antivirus_path\s*/.*):#\1:' \
			-e 's:^(\s*antivirus_args\s*.*):#\1:' \
			${D}/etc/sympa/sympa.conf
	fi
	# Update openssl config
	if useq ssl; then
		sed -i -r \
			-e 's:^#?\s*openssl\s*/.*:openssl /usr/bin/openssl:' \
			-e 's:^#?\s*capath\s*/.*:capath /etc/ssl/certs:' \
			-e 's:^#?\s*cafile\s*/.*:cafile /etc/ssl/certs/ca-certificates.crt:' \
			${D}/etc/sympa/sympa.conf
	else
		sed -i -r \
			-e 's:^(\s*openssl\s*/.*):#\1:' \
			-e 's:^(\s*capath\s*/.*):#\1:' \
			-e 's:^(\s*cafile\s*/.*):#\1:' \
			${D}/etc/sympa/sympa.conf
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
	fowners ${SYMPA_USER}:${SYMPA_GROUP} /var/lib/sympa/lists

	newdoc ${FILESDIR}/${PN}-apache.conf apache.conf || \
		die "newdoc failed"
	newdoc ${FILESDIR}/${PN}-apache_soap.conf apache_soap.conf || \
		die "newdoc failed"
	newdoc ${FILESDIR}/${PN}-lighttpd.conf lighttpd.conf ||\
		die "newdoc failed"
	newdoc ${FILESDIR}/${PN}-lighttpd_soap.conf lighttpd_soap.conf ||\
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

	if useq clamav; then
		elog "By default we use clamscan antivirus scanner"
		elog "(antivirus_path option in sympa.conf). For performance"
		elog "reason you might want to use clamdscan which is much faster."
		elog "To use it you need to do the following:"
		elog
		elog "# gpasswd -a clamav sympa"
		elog "# /etc/init.d/clamd restart"
		elog
	fi
}
