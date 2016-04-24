# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit webapp depend.php

DESCRIPTION="File sharing platform similar to dropbox"
HOMEPAGE="https://pyd.io/"
SRC_URI="http://sourceforge.net/projects/ajaxplorer/files/${PN}/stable-channel/${PV}/${PN}-core-${PV}.tar.gz/download -> ${P}.tar.gz"
RESTRICTION="mirror"

LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="+webdav"

DEPEND="webdav? ( dev-php/PEAR-HTTP_WebDAV_Client )"
RDEPEND="${DEPEND}"

need_php_httpd

S="${WORKDIR}/${PN}-core-${PV}"

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r "${S}"/*

	insinto "${MY_HTDOCSDIR}"/upgrade-scripts
	doins "${FILESDIR}"/*.php

	webapp_serverowned -R "${MY_HTDOCSDIR}"/data

	webapp_configfile "${MY_HTDOCSDIR}/base.conf.php"
	webapp_configfile "${MY_HTDOCSDIR}/conf/bootstrap_"{conf,context,repositories}".php"
	webapp_configfile "${MY_HTDOCSDIR}/conf/mime.types"
	webapp_configfile "${MY_HTDOCSDIR}/conf/extensions.conf.php"

	# FIXME: does not fit eclass design
	#webapp_sqlscript mysql "${MY_HTDOCSDIR}"/plugins/*/create.mysql
	#webapp_sqlscript postgres "${MY_HTDOCSDIR}"/plugins/*/create.pgsql

	webapp_sqlscript mysql "${FILESDIR}"/6.2.0.mysql 6.0
	webapp_sqlscript postgres "${FILESDIR}"/6.2.0.pgsql 6.0

	webapp_postinst_txt en "${FILESDIR}"/postinst.en.txt

	webapp_src_install
}
