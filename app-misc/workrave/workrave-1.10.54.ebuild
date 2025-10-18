# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python3_{10..12} )

inherit autotools gnome2 python-single-r1 vcs-snapshot

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="https://workrave.org/"
MY_PV=$(ver_rs 1- '_')
SRC_URI="https://github.com/rcaelers/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="dbus doc gnome gstreamer introspection mate nls pulseaudio test xfce"
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	>=dev-libs/glib-2.28.0:2
	>=x11-libs/gtk+-3.0:3[introspection?,X]
	>=dev-cpp/gtkmm-3.18.0:3.0
	>=dev-cpp/glibmm-2.28.0:2
	>=dev-libs/libsigc++-2.2.4.2:2
	dbus? (
		dev-libs/boost
		dev-libs/dbus-glib
		>=sys-apps/dbus-1.2
		${PYTHON_DEPS}
		gnome? ( gnome-base/gnome-panel )
	)
	gnome? ( >=gnome-base/gnome-shell-3.6.2 )
	gstreamer? (
		media-libs/gstreamer:1.0[introspection?]
		media-libs/gst-plugins-base:1.0[introspection?]
		media-plugins/gst-plugins-meta:1.0 )
	introspection? ( dev-libs/gobject-introspection:= )
	mate? ( mate-base/mate-applets )
	pulseaudio? ( media-libs/libpulse )
	xfce? (
		>=x11-libs/gtk+-2.6.0:2[introspection?]
		>=xfce-base/xfce4-panel-4.4 )
	x11-libs/libXScrnSaver
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXt
	x11-libs/libXmu
"
DEPEND="${RDEPEND}
	dev-build/autoconf-archive
	dev-util/glib-utils
	>=dev-util/intltool-0.40.0
	x11-base/xorg-proto
	virtual/pkgconfig
	dbus? ( dev-python/jinja2 )
	doc? (
		app-text/docbook-sgml-utils
		app-text/xmlto )
	nls? ( >=sys-devel/gettext-0.17 )
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_unpack() {
	vcs-snapshot_src_unpack
}

src_prepare() {
	# Fix gstreamer slot automagic dependency, bug #563584
	# http://issues.workrave.org/show_bug.cgi?id=1179
	eapply "${FILESDIR}"/${PN}-automagic-gstreamer.patch

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	# gnet ("distribution") is dead for ages and other distributions stopped
	# relying on it for such time too.
	gnome2_src_configure \
		--disable-distribution \
		--enable-exercises \
		--disable-experimental \
		--disable-static \
		--disable-xml \
		--disable-indicator \
		$(use_enable dbus) \
		$(use_enable doc manual) \
		$(use_enable gnome gnome3) \
		$(use_enable gstreamer) \
		$(use_enable introspection) \
		$(use_enable mate) \
		$(use_enable nls) \
		$(use_enable pulseaudio pulse) \
		$(use_enable test tests) \
		$(use_enable xfce)
}
