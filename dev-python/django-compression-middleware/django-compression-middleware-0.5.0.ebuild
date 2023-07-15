# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Django middleware to compress responses using several algorithms."
HOMEPAGE="https://github.com/friedelwolff/django-compression-middleware"

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
