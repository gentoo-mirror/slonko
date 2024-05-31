# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )
inherit distutils-r1

DESCRIPTION="Pickled object field for Django"
HOMEPAGE="https://github.com/gintas/django-picklefield"
SRC_URI="https://github.com/gintas/django-picklefield/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/django-3.2[${PYTHON_USEDEP}]
"

DOCS=( README.rst )

python_test() {
	"${EPYTHON}" -m django test -v2 --settings=tests.settings || die "Tests fail with ${EPYTHON}"
}
