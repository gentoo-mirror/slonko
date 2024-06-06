# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Library of web-related functions"
HOMEPAGE="
	https://scrapy.org/
	https://pypi.org/project/w3lib/
	https://github.com/scrapy/w3lib
"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/sphinx-hoverxref \
	dev-python/sphinx-notfound-page \
	dev-python/sphinx-rtd-theme
