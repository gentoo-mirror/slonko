# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PROG="${P}-1"

DESCRIPTION="Epson scanner management utility"
HOMEPAGE="https://support.epson.net/linux/en/epsonscan2.php"
SRC_URI="https://download3.ebz.epson.net/dsc/f/03/00/17/08/06/1babf9876ebb16956420a601b92ee28b57cd7db7/${MY_PROG}.src.tar.gz"
S="${WORKDIR}/${MY_PROG}"

inherit cmake desktop flag-o-matic udev

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bundled-libs"

DEPEND="
	dev-libs/boost
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	media-gfx/sane-backends
	media-libs/libjpeg-turbo:=
	media-libs/libpng
	media-libs/tiff
	virtual/libusb:1
	!bundled-libs? (
		media-libs/libharu
		sys-libs/zlib
	)
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/0002-Fix-crash.patch"
	"${FILESDIR}/0003-Use-XDG-open-to-open-the-directory.patch"
	"${FILESDIR}/0004-Fix-a-crash-on-an-OOB-container-access.patch"
	"${FILESDIR}/0005-Fix-folder-creation-crash.patch"
	"${FILESDIR}/0006-Fix-desktop-deprecated.patch"
)

src_prepare() {
	sed -i \
		-e '/\(execute_process.*\)${EPSON_INSTALL_ROOT}/d' \
		-e "s|^\(set(EPSON_VERSION \).*|\1-${PV})|g" \
		CMakeLists.txt || die
	if ! use bundled-libs; then
		# Force usage of system libraries
		rm -rf thirdparty/{HaruPDF,zlib}
		sed -i \
			-e '/thirdparty\/HaruPDF/d' \
			-e '/thirdparty\/zlib/d' \
			-e 's|^\([[:blank:]]*\)\(usb-1.0\)|\1\2\n\1hpdf\n\1z|' \
			src/Controller/CMakeLists.txt || die
	fi

	# Boost 1.87 compatibility (BOOST_NO_CXX11_RVALUE_REFERENCES should be set by Boost)
	find . -name CMakeLists.txt -exec sed -e '/add_definitions.*DBOOST_NO_CXX11_RVALUE_REFERENCES/d' -i {} \;
	find . \( -name "*.h" -o -name "*.hpp" -o -name "*.cpp" \) \
		-exec sed -e '/#define.*BOOST_NO_CXX11_RVALUE_REFERENCES/d' -i {} \;

	# Fix compilation failure with GCC 15
	append-cxxflags $(test-flags-CXX -Wno-template-body)
	sed -i '/#include/ i #include <cmath>' 'src/Controller/Src/Filter/GrayToMono.hpp' || die

	cmake_src_prepare
}

src_install() {
	cmake_src_install
	# Sane symlinks
	dosym ../epsonscan2/libsane-epsonscan2.so /usr/$(get_libdir)/sane/libsane-epsonscan2.so.1
	dosym ../epsonscan2/libsane-epsonscan2.so /usr/$(get_libdir)/sane/libsane-epsonscan2.so.1.0.0
	# Desktop icon
	domenu desktop/rpm/x86_64/epsonscan2.desktop
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
