# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Module that wraps pdftoppm and pdftocairo to convert PDF to a PIL Image object"
HOMEPAGE="https://github.com/Belval/pdf2image"
SRC_URI="https://github.com/Belval/pdf2image/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-text/poppler[cairo,jpeg,jpeg2k,png,tiff,utils]
	dev-python/pillow
"

distutils_enable_tests unittest
distutils_enable_sphinx docs \
	dev-python/recommonmark \
	dev-python/sphinx-rtd-theme
