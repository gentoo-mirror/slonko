# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="Whoosh-Reloaded"
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1 pypi

DESCRIPTION="Fast, pure-Python full text indexing, search, and spell checking library."
HOMEPAGE="
	https://pypi.org/project/Whoosh-Reloaded/
	https://github.com/Sygil-Dev/whoosh-reloaded
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-python/cached-property-2.0.1[${PYTHON_USEDEP}]"
RDEPND="!dev-python/whoosh[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
#distutils_enable_sphinx docs/source \
#	dev-python/sphinx-rtd-theme
#	dev-python/sphinx-jsonschema
