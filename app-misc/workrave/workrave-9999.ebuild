# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )

inherit cmake python-single-r1 vcs-snapshot

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="https://workrave.org/"
MY_PV=$(ver_rs 1- '_')
if [[ ${PV} == 9999* ]]; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/rcaelers/${PN}"
        S="${WORKDIR}/${P}"
else
		SRC_URI="https://github.com/rcaelers/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
        KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"

IUSE="gui nls"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${RDEPEND}
	>=x11-themes/adwaita-icon-theme-43
	>=dev-libs/spdlog-1.10.0
	>=dev-cpp/gtkmm-3.24.5
	>=x11-libs/gtk+-3.24.34
	>=dev-util/pkgconf-1.8.0
	>=dev-libs/boost-1.79.0
	nls? ( >=sys-devel/gettext-0.21 )
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
}

pkg_postinst() {
	use gui && xdg_icon_cache_update
}

pkg_postrm() {
	use gui && xdg_icon_cache_update
}
