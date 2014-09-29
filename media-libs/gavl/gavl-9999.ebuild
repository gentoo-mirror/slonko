# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gavl/gavl-1.0.0.ebuild,v 1.2 2008/05/21 19:14:43 mr_bones_ Exp $

inherit autotools eutils cvs

DESCRIPTION="library for handling uncompressed audio and video data"
HOMEPAGE="http://gmerlin.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug doc"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

ECVS_SERVER="gmerlin.cvs.sourceforge.net:/cvsroot/gmerlin"
ECVS_MODULE="gavl"
S=${WORKDIR}/${ECVS_MODULE}

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-cflags.patch
	sed -i -e "s:-mfpmath=387::g" configure.ac || die "sed failed."
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	# --disable-libpng because it's only used for tests
	econf $(use_with doc doxygen) --disable-libpng \
		$(use_enable debug debug) \
		--without-cpuflags --disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF}/html
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README TODO
}
