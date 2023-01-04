# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="A collection of custom extensions for the Django Framework"
HOMEPAGE="https://github.com/django-extensions/django-extensions"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/django-3.2[${PYTHON_USEDEP}]
"

DOCS=( README.rst CHANGELOG.md )

# TODO: tests
#distutils_enable_tests unittest
#
#python_test() {
#	"${EPYTHON}" -m django test -v2 --settings=tests.testapp.settings || die "Tests fail with ${EPYTHON}"
#}
