# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

MY_P="${PN}_${PV/./}"

DESCRIPTION="UCI adapter to connect a UCI chess engine to an xboard interface"
HOMEPAGE="http://wbec-ridderkerk.nl/html/details1/PolyGlot.html"
SRC_URI="http://wbec-ridderkerk.nl/html/downloada/fruit/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Respect {CXX,LD}FLAGS, don't strip
	sed -i \
		-e "s:\(CXX\|LD\)FLAGS \+=:\1FLAGS +=:" \
		-e "/LDFLAGS.*-s/d" \
		src/Makefile || die "sed in Makefile failed"
}

src_compile() {
	cd src
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/${PN} || die "dobin failed"
	dodoc readme.txt || die "dodoc failed"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${WORKDIR}"/example/* || die "doins failed"
	fi
}
