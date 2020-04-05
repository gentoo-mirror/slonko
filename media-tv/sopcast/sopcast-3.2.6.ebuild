# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils
RESTRICT="nomirror"

MY_P="sp-auth"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="SopCast free P2P Internet TV binary"
LICENSE="SopCast-unknown-license"
HOMEPAGE="http://www.sopcast.com/"
SRC_URI="http://download.sopcast.com/download/${MY_P}.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

# All dependencies might not be listed, since the binary blob's homepage only lists libstdc++
RDEPEND=">=virtual/libstdc++-3.3"

DEPEND="${RDEPEND}"

src_unpack() {
	ewarn "SopCast binary blob is distributed without version info in its package."
	ewarn "Thus, in case this ebuild fails, you might want to remove your " $MY_SRC
	ewarn "from /usr/portage/distfiles and check whether they have release a newer"
	ewarn "version on their homepage at"
	ewarn $HOMEPAGE

	unpack ${A}
}

src_install() {
	exeinto /opt/${PN}
	doexe sp-sc-auth
	dosym /opt/${PN}/sp-sc-auth /usr/bin/sp-sc
	dodoc Readme
}
