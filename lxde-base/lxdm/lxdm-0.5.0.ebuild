# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxdm/lxdm-0.4.1-r8.ebuild,v 1.2 2013/12/22 12:46:59 pacho Exp $

EAPI="5"

WANT_AUTOMAKE="1.12" #493996
inherit eutils autotools systemd

DESCRIPTION="LXDE Display Manager"
HOMEPAGE="http://lxde.org"
SRC_URI="mirror://sourceforge/lxdm/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"

IUSE="consolekit debug gtk3 nls pam"

RDEPEND="consolekit? ( sys-auth/consolekit )
	x11-libs/libxcb
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( x11-libs/gtk+:2 )
	nls? ( sys-devel/gettext )
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig"

src_prepare() {
	cd "${S}"
	# Upstream bug, tarball contains pre-made lxdm.conf
	rm data/lxdm.conf || die

	sed -i -e '/pam_console.so/d' pam/lxdm

	# Allow user to apply any additional patches without modifing ebuild
    epatch_user

	# this replaces the bootstrap/autogen script in most packages
	eautoreconf

	# process LINGUAS
	if use nls; then
		einfo "Running intltoolize ..."
		intltoolize --force --copy --automake || die
		strip-linguas -i "${S}/po" || die
	fi
}
src_configure() {
	econf	--enable-password \
		--with-x \
		--with-xconn=xcb \
		$(use_enable consolekit) \
		$(use_enable gtk3) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_with pam)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS COPYING INSTALL README TODO || die
}

pkg_postinst() {
	echo
	elog "Take into consideration that LXDM is in the early stages of development!"
	echo
}
