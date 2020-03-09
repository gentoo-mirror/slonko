# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic udev

DESCRIPTION="EPSON Image Scan v3 for Linux"
HOMEPAGE="https://support.epson.net/linux/en/imagescanv3.php"
SRC_URI="https://support.epson.net/linux/src/scanner/imagescanv3/common/imagescan_${PV}.orig.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
IUSE="graphicsmagick gui imagemagick"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/boost:=
	media-gfx/sane-backends
	media-libs/tiff
	virtual/libusb:1
	virtual/jpeg
	gui? ( dev-cpp/gtkmm:2.4 )
	imagemagick? (
		!graphicsmagick? ( media-gfx/imagemagick:= )
		graphicsmagick? ( media-gfx/graphicsmagick:= )
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/utsushi-0.$(ver_cut 2-3)"

PATCHES=(
	"${FILESDIR}"/${P}-ijg-libjpeg.patch
	"${FILESDIR}"/${P}-imagemagick-7.patch
)

src_prepare() {
	default

	# Remove vendored libraries
	rm -r upstream/boost || die
	# Workaround for deprecation warnings:
	# https://gitlab.com/utsushi/utsushi/issues/90
	sed -e 's|-Werror||g' -i configure.ac || die
	eautoreconf
}

src_configure() {
	# Workaround: https://gitlab.com/utsushi/utsushi/issues/91
	append-ldflags $(no-as-needed)
	econf \
		$(use_with gui gtkmm) \
		$(use_with imagemagick magick) \
		$(use_with imagemagick magick-pp) \
		--enable-sane-config \
		--enable-udev-config \
		--with-boost=yes \
		--with-jpeg \
		--with-sane \
		--with-tiff \
		--with-udev-confdir="$(get_udevdir)"
}

src_install() {
	default
	dodoc lib/devices.conf
	find "${ED}" -name '*.la' -delete || die

	elog "If you encounter problems with media-gfx/xsane when scanning (e.g., bad resolution),"
	elog "please try the built-in GUI and kde-misc/skanlite first before reporting bugs."
}
