# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Sphinx extension to show tooltips with content embedded when hover a reference"
HOMEPAGE="
	https://pypi.org/project/sphinx-hoverxref/
	https://github.com/readthedocs/sphinx-hoverxref
"
SRC_URI="https://github.com/readthedocs/sphinx-hoverxref/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
PROPERTIES="test_network"

RDEPEND="
	>=dev-python/sphinx-5.0[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-jquery[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/sphinxcontrib-bibtex-2.6.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs \
#	dev-python/sphinx-autoapi \
#	dev-python/sphinxcontrib-bibtex \
#	dev-python/sphinx-notfound-page \
#	dev-python/sphinx-prompt \
#	dev-python/sphinx-rtd-theme \
#	dev-python/sphinx-tabs \
#	dev-python/sphinxemoji
