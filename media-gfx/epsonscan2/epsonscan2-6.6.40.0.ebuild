# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_VERSION="${PV}-1"

DESCRIPTION="Epson scanner management utility"
HOMEPAGE="https://support.epson.net/linux/en/epsonscan2.php"
SRC_URI="https://support.epson.net/linux/src/scanner/${PN}/${PN}-${MY_VERSION}.src.tar.gz"
S="${WORKDIR}/${PN}-${MY_VERSION}"

inherit cmake

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/boost
	dev-libs/rapidjson
	media-gfx/sane-backends
	media-libs/libharu
	media-libs/libpng
	media-libs/tiff
	virtual/jpeg
	virtual/libusb:1
"
# dev-qt/qtsingleapplication
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	cmake_src_prepare
	sed -i \
		-e "s|\(execute_process.*\)\${EPSON_INSTALL_ROOT}|\1${D}|g" \
		-e "s|^\(set(EPSON_VERSION \).*|\1-${PV})|g" \
		CMakeLists.txt || die
	rm -rf thirdparty/{HaruPDF,rapidjson,zlib}
	sed -i \
		-e '/thirdparty\/HaruPDF/d' \
		-e '/thirdparty\/zlib/d' \
		-e 's|^\([[:blank:]]*\)\(usb-1.0\)|\1\2\n\1hpdf\n\1z|' \
		src/Controller/CMakeLists.txt || die
}
