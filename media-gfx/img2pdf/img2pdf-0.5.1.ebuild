# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 pypi

DESCRIPTION="Losslessly convert raster images to PDF"
HOMEPAGE="https://gitlab.mister-muffin.de/josch/img2pdf"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="amd64 ppc64 x86"
IUSE="gui"

BDEPEND="
	test? (
		app-text/ghostscript-gpl
		app-text/mupdf
		app-text/poppler[cairo,png,tiff]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pdfrw[${PYTHON_USEDEP}]
		dev-python/pillow[tiff,${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		media-gfx/imagemagick[jpeg,jpeg2k,lcms,png,-q8,-q32,tiff]
		media-libs/exiftool
		media-libs/netpbm[jpeg]
		sys-libs/libfaketime
	)
"
RDEPEND="
	dev-python/pikepdf[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	media-libs/icc-profiles-openicc
	gui? ( $(python_gen_impl_dep tk) )
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Failing cmyk8 tests
	src/img2pdf_test.py::test_miff_cmyk8
)

src_prepare() {
	distutils-r1_python_prepare_all

	# Remove gui executable if there's no demand/support for it.
	if ! use gui; then
		sed -i '/gui_scripts/d' setup.py || die
	fi
}
