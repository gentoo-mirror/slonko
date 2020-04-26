# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit webapp eutils

DESCRIPTION="Web based (PHP Script) photo album viewer/creator"
HOMEPAGE="http://galleryproject.org/"

LICENSE="GPL-2"
IUSE="ffmpeg +gd imagemagick +mysql netpbm postgres raw sqlite unzip zip"

case ${PV} in
*.9999)
	EGIT_REPO_URI="https://github.com/gregstoll/gallery2"
	inherit git-r3
	;;
*)
	KEYWORDS="amd64 hppa ppc ppc64 x86"
	SRC_URI="mirror://sourceforge/${PN}/${P}-full.tar.gz"
	S=${WORKDIR}/${PN}2
	;;
esac

RDEPEND="raw? ( media-gfx/dcraw )
	ffmpeg? ( virtual/ffmpeg )
	imagemagick? ( || ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] ) )
	netpbm? ( media-libs/netpbm media-gfx/jhead )
	unzip? ( app-arch/unzip )
	zip? ( app-arch/zip )
	sqlite? ( dev-lang/php[pdo] dev-lang/php[sqlite] )
	mysql? ( || ( dev-lang/php[mysql] dev-lang/php[mysqli] ) )
	dev-lang/php[session,postgres?,gd?]
	virtual/httpd-php"

REQUIRED_USE="
	|| ( gd imagemagick netpbm )
	|| ( mysql postgres sqlite )
"

need_httpd_cgi

pkg_setup() {
	webapp_pkg_setup
}

src_prepare() {
	eapply_user
}

src_install() {
	webapp_src_preinst

	HTML_DOCS="README.html" einstalldocs
	rm README.html LICENSE
	sed -i -e "/^LICENSE\>/d" -e "/^README\.html\>/d" MANIFEST

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_postinst_txt en "${FILESDIR}/postinstall-en2.txt"
	webapp_src_install
}

pkg_postinst() {
	elog "You are strongly encouraged to back up your database"
	elog "and the g2data directory, as upgrading may make"
	elog "irreversible changes to both."
	elog
	elog "g2data dir: cp -Rf /path/to/g2data/ /path/to/backup"
	elog "mysql: mysqldump --opt -u username -h hostname -p database > /path/to/backup.sql"
	elog "postgres: pg_dump -h hostname --format=t database > /path/to/backup.sql"
	webapp_pkg_postinst
}
