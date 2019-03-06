# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit cmake-utils eutils gnome2-utils python-single-r1 toolchain-funcs versionator

BRANCH="$(get_version_component_range 1-3)"
MINOR="$(get_version_component_range 4)"

if [[ ${MINOR} == 9999 ]]; then
	EBZR_REPO_URI="http://bazaar.launchpad.net/~compiz-team/compiz/${BRANCH}"
	inherit bzr
else
	SRC_URI="http://launchpad.net/${PN}/${BRANCH}/${PV}/+download/${P}.tar.bz2"
fi

KEYWORDS="~amd64"
DESCRIPTION="OpenGL window and compositing manager"
HOMEPAGE="http://www.compiz.org/"

LICENSE="GPL-2 LGPL-2.1 MIT"
SLOT="0"

IUSE="+cairo debug dbus fuse gles gnome gtk kde +svg test"

COMMONDEPEND="
	!x11-wm/compiz-fusion
	!x11-libs/compiz-bcop
	!x11-libs/libcompizconfig
	!x11-libs/compizconfig-backend-gconf
	!x11-libs/compizconfig-backend-kconfig4
	!x11-plugins/compiz-plugins-main
	!x11-plugins/compiz-plugins-extra
	!x11-plugins/compiz-plugins-unsupported
	!x11-apps/ccsm
	!dev-python/compizconfig-python
	!x11-apps/fusion-icon
	dev-libs/boost
	dev-libs/glib:2
	dev-cpp/glibmm
	dev-libs/libxml2
	dev-libs/libxslt
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/pyrex
	dev-libs/protobuf
	media-libs/libpng
	x11-base/xorg-server
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXinerama
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/startup-notification
	virtual/opengl
	virtual/glu
	cairo? ( x11-libs/cairo[X] )
	fuse? ( sys-fs/fuse )
	gtk? (
		x11-libs/gtk+:3
		x11-libs/libwnck:3
		x11-libs/pango
		gnome? (
			gnome-base/gnome-desktop
			gnome-base/gconf
			x11-wm/metacity
		)
	)
	kde? ( kde-base/kwin:4 )
	svg? (
		gnome-base/librsvg:2
		x11-libs/cairo
	)
	dbus? ( sys-apps/dbus )"

DEPEND="${COMMONDEPEND}
	app-admin/chrpath
	virtual/pkgconfig
	x11-proto/damageproto
	x11-proto/xineramaproto
	test? (
		dev-cpp/gtest
		dev-cpp/gmock
	)"

RDEPEND="${COMMONDEPEND}
	dev-python/pygtk
	x11-apps/mesa-progs
	x11-apps/xvinfo
	x11-themes/hicolor-icon-theme"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		[[ $(gcc-major-version) -lt 4 ]] || \
		( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -lt 6 ]] ) \
		&& die "Sorry, but gcc 4.6 or higher is required."
	fi
}

src_unpack() {
	if [[ ${MINOR} == 9999 ]]; then
		bzr_src_unpack
	else
		default
	fi
}

src_prepare() {
	cmake-utils_src_prepare
	sed -i -e 's/CYTHON_BIN cython3/CYTHON_BIN cython/' compizconfig/compizconfig-python/CMakeLists.txt
	epatch "${FILESDIR}"/access_violation.patch
	eapply_user
}

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	use debug && CMAKE_BUILD_TYPE=Debug
	local mycmakeargs=(
		"-DUSE_GLES=$(usex gles)"
		"-DUSE_GNOME=$(usex gnome)"
		"-DUSE_METACITY=$(usex gnome)"
		"-DUSE_GTK=$(usex gtk)"
		"-DUSE_KDE4=$(usex kde)"
		"-DCOMPIZ_BUILD_TESTING=$(usex test)"
		"-DCMAKE_BUILD_TYPE=Release"
		"-DCMAKE_INSTALL_PREFIX=/usr"
		"-DCOMPIZ_DEFAULT_PLUGINS=composite,opengl,decor,resize,place,move,ccp"
		"-DCOMPIZ_DISABLE_SCHEMAS_INSTALL=On"
		"-DCOMPIZ_PACKAGING_ENABLED=On"
		"-DCOMPIZ_BUILD_WITH_RPATH=Off"
		"-DCOMPIZ_BUILD_TESTING=Off"
		"-DCOMPIZ_WERROR=Off"
		"-Wno-dev"
	)
	cmake-utils_src_configure
}

pkg_preinst() {
	use gnome && gnome2_gconf_savelist
	gnome2_icon_savelist
}

pkg_postinst() {
	use gnome && gnome2_gconf_install
	gnome2_icon_cache_update
	if use dbus; then
		ewarn "The dbus plugin is known to crash compiz in this version. Disable"
		ewarn "it if you experience crashes when plugins are enabled/disabled."
	fi
}

pkg_prerm() {
	use gnome && gnome2_gconf_uninstall
	gnome2_icon_cache_update
}
