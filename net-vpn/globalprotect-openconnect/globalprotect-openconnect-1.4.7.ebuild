# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GlobalProtect VPN GUI based on Openconnect with SAML auth mode support"
HOMEPAGE="https://github.com/yuezk/GlobalProtect-openconnect"
SRC_URI="https://github.com/yuezk/GlobalProtect-openconnect/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/GlobalProtect-openconnect-${PV}"

inherit cmake git-r3

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

PLOG_REPO='https://github.com/SergiusTheBest/plog.git'
PLOG_VERSION='1.1.6'
SINGLEAPP_REPO='https://github.com/itay-grudev/SingleApplication.git'
SINGLEAPP_VERSION='3.3.4'

src_unpack() {
	default_src_unpack
	## 3rd party submodules
	# Plog
	EGIT_REPO_URI="${PLOG_REPO}"
	EGIT_COMMIT="${PLOG_VERSION}"
	EGIT_CHECKOUT_DIR="${S}/3rdparty/plog"
	git-r3_src_unpack
	# SingleApplication
	EGIT_REPO_URI="${SINGLEAPP_REPO}"
	EGIT_COMMIT="v${SINGLEAPP_VERSION}"
	EGIT_CHECKOUT_DIR="${S}/3rdparty/SingleApplication"
	git-r3_src_unpack
}

src_compile() {
	cmake -B build -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr" -DCMAKE_BUILD_TYPE=Release
	cmake --build build
}

src_install() {
	emake DESTDIR="${D}" install -C build
}
