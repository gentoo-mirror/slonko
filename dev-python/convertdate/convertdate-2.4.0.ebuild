# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Converts between Gregorian dates and other calendar systems."
HOMEPAGE="https://github.com/fitnr/convertdate https://pypi.org/project/convertdate/"
SRC_URI="https://github.com/fitnr/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md )

RDEPEND="
	>=dev-python/pymeeus-0.3.13[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/myst-parser \
	dev-python/sphinx-rtd-theme
