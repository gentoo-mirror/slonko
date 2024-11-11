# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit cmake python-single-r1 xdg-utils

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

IUSE="dbus debug gstreamer +gtk indicator mate nls pulseaudio test wayland xfce"
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	>=x11-themes/adwaita-icon-theme-43
	>=dev-libs/spdlog-1.10.0
	>=dev-util/pkgconf-1.8.0
	>=dev-libs/boost-1.73.0
	dbus? (
		${PYTHON_DEPS}
		dev-python/jinja2
	)
	gstreamer? ( media-libs/gstreamer:1.0 )
	gtk? (
		>=dev-libs/glib-2.56.0
		>=x11-libs/gtk+-3.22.0
		>=dev-cpp/gtkmm-3.22.0
	)
	indicator? (
		>=dev-libs/libayatana-indicator-0.4:3
	)
	mate? ( >=mate-base/mate-panel-1.20.0 )
	nls? ( >=sys-devel/gettext-0.21 )
	pulseaudio? (
		dev-libs/glib:2
		media-libs/libpulse
	)
	xfce? ( >=xfce-base/xfce4-panel-4.12 )
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_DBUS=$(usex dbus)
		-DWITH_GSTREAMER=$(usex gstreamer)
		-DWITH_INDICATOR=$(usex indicator)
		-DWITH_MATE=$(usex mate)
		-DWITH_PULSE=$(usex pulseaudio)
		-DWITH_TESTS=$(usex test)
		-DWITH_TRACING=$(usex debug)
		-DWITH_UI=$(usex gtk Gtk+3 None)
		-DWITH_WAYLAND=$(usex wayland)
		-DWITH_XFCE4=$(usex xfce)
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
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
