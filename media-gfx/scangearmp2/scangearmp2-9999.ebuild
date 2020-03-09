# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils flag-o-matic autotools multilib desktop

DESCRIPTION="Canon InkJet Scanner Driver and ScanGear MP for Linux (Pixus/Pixma-Series)."
HOMEPAGE="https://support-au.canon.com.au/contents/AU/EN/0100303302.html"
RESTRICT="mirror"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Ordissimo/${PN}.git"
	S="${WORKDIR}/${P}"
else
	SRC_URI="https://gdlp01.c-wss.com/gds/3/0100009933/01/${PN}-source-${PV}-1.tar.gz"
	S="${WORKDIR}/${PN}-source-${PV}-1"
fi

LICENSE="GPL-2"

SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="+sane usb"
DEPEND="
	virtual/libusb:1
	>=x11-libs/gtk+-2.16.0"

src_prepare() {
	cd ${PN}
	eapply_user
	eautoreconf
}

src_configure() {
	cd ${PN}

	if use x86; then
		LDFLAGS="-L$(pwd)/../com/libs_bin32"
	elif use amd64 ; then
		LDFLAGS="-L$(pwd)/../com/libs_bin64"
	else
		die "Not supported arch"
	fi
	econf LDFLAGS="${LDFLAGS}"
}

src_compile() {
	pushd ${PN}
	make || die "Couldn't build ${PN}"
	popd
}

src_install() {
	pushd ${PN}
	make DESTDIR="${D}" install || die "Couldn't make install ${PN}"
	popd
	domenu "${FILESDIR}"/${PN}.desktop

	_libdir="/usr/$(get_libdir)"
	_udevdir="/lib/udev/rules.d"

	dodir ${_libdir}
	if use x86; then
		cp -a com/libs_bin32/* "${D}${_libdir}"
	else
		cp -a com/libs_bin64/* "${D}${_libdir}"
	fi

	# usb
	if use usb; then
		install -D -m 644 scangearmp2/etc/80-canon_mfp2.rules "${D}${_udevdir}"/80-canon_mfp2.rules
	fi
	# sane
	if use sane; then
		install -D -m 755 scangearmp2/src/.libs/libsane-canon_pixma.so.1.0.0 "${D}${_libdir}"/sane/libsane-canon_pixma.so.1.0.0
		ln -sf "${_libdir}"/sane/libsane-canon_pixma.so.1.0.0 "${D}${_libdir}"/sane/libsane-canon_pixma.so.1
		ln -sf "${_libdir}"/sane/libsane-canon_pixma.so.1.0.0 "${D}${_libdir}"/sane/libsane-canon_pixma.so
		install -d "${D}"/etc/sane.d/dll.d
		echo canon_pixma > "${D}"/etc/sane.d/dll.d/canon_pixma.conf
	fi
}

pkg_postinst() {
	if use usb; then
		if [ -x /sbin/udevadm ]; then
			einfo ""
			einfo "Reloading usb rules..."
			/sbin/udevadm control --reload-rules 2> /dev/null
			/sbin/udevadm trigger --action=add --subsystem-match=usb 2>/dev/null
		else
			einfo ""
			einfo "Please, reload usb rules manually."
		fi
	fi
}
