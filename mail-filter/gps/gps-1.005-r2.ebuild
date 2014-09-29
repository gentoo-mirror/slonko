# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit autotools eutils

DESCRIPTION="Postfix greylisting policer"
HOMEPAGE="http://mimo.gn.apc.org/gps"
SRC_URI="http://downloads.sourceforge.net/greylist/${P}-bugfix.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="doc"

RDEPEND="dev-db/libdbi "
DEPEND="${RDEPEND}"

# USE_DESTDIR="1"

S=${WORKDIR}/release-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patch to accept numeric values to configure libdbi drivers
	epatch "${FILESDIR}/${PN}-numeric.diff"
	# Do not stip hostname if less than 2 dots
	epatch "${FILESDIR}/${PN}-two-dots.diff"
	# Make SQLite compatible index
	epatch "${FILESDIR}/${PN}-create-index.diff"
	# gcc 4.7+ compatibility
	epatch "${FILESDIR}/${PN}-gcc47.diff"

	eautoreconf || die "Failed reconfiguration"
}

src_install() {
	dobin src/gps

	insinto /etc
	doins etc/gps.conf

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO

	docinto config
	dodoc etc/*

	docinto tests
	dodoc tests/*

	docinto tools
	dodoc tools/*

	dohtml src/gps-header.html
}
