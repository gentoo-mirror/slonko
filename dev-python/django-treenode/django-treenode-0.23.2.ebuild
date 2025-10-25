# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Probably the best abstract model / admin for your tree based stuff."
HOMEPAGE="https://github.com/fabiocaccamo/django-treenode"
SRC_URI="https://github.com/fabiocaccamo/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

DOCS=( README.md )

python_test() {
	"${EPYTHON}" -m django test -v2 --settings=tests.settings || die "Tests fail with ${EPYTHON}"
}
