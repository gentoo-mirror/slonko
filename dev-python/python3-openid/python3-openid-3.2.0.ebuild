# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="OpenID support for modern servers and consumers"
HOMEPAGE="https://github.com/necaris/python3-openid"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/defusedxml[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/psycopg:2[${PYTHON_USEDEP}]
	)
"

DOCS=( NEWS.md README.md )

distutils_enable_tests unittest
python_test() {
	"${EPYTHON}" -m unittest -v openid.test.test_suite || die "Tests failed with ${EPYTHON}"
}
