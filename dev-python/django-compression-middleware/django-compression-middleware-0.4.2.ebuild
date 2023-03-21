# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1

DESCRIPTION="Django middleware to compress responses using several algorithms."
HOMEPAGE="https://github.com/friedelwolff/django-compression-middleware"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-arch/brotli[python,${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/zstandard[${PYTHON_USEDEP}]
"

DOCS=( README.rst )

distutils_enable_tests pytest
