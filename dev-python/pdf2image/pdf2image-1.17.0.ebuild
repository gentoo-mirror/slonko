# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 pypi

DESCRIPTION="Module that wraps pdftoppm and pdftocairo to convert PDF to a PIL Image object"
HOMEPAGE="https://github.com/Belval/pdf2image"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-text/poppler
	dev-python/pillow
"
