# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GlobalProtect VPN GUI based on Openconnect with SAML auth mode support"
HOMEPAGE="https://github.com/yuezk/GlobalProtect-openconnect"
SRC_URI="https://github.com/yuezk/GlobalProtect-openconnect/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/GlobalProtect-openconnect-${PV}"

inherit cmake

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtcore
	dev-qt/qtdbus
	dev-qt/qtnetwork
	dev-qt/qtwebengine
	dev-qt/qtwebsockets
	dev-qt/qtwidgets
	net-vpn/openconnect
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	cmake -B build -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr" -DCMAKE_BUILD_TYPE=Release
	cmake --build build
}

src_install() {
	emake DESTDIR="${D}" install -C build
}
