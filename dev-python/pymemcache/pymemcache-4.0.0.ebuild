# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{8..13} python3_13t )
inherit distutils-r1

DESCRIPTION="A comprehensive, fast, pure-Python memcached client."
HOMEPAGE="https://github.com/pinterest/pymemcache"
SRC_URI="https://github.com/pinterest/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/faker[${PYTHON_USEDEP}]
		dev-python/pylibmc[${PYTHON_USEDEP}]
		dev-python/python-memcached[${PYTHON_USEDEP}]
		dev-python/zstd[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme \
	dev-python/sphinxcontrib-apidoc

src_prepare() {
	sed -i -e '/--cov=/d' setup.cfg || die

	distutils-r1_src_prepare
}
