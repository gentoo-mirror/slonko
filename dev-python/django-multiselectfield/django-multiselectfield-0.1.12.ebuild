# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Django multiple select field"
HOMEPAGE="https://github.com/goinnn/django-multiselectfield"
SRC_URI="https://github.com/goinnn/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[sqlite,${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

DOCS=( README.rst )

#python_test() {
#	"${EPYTHON}" example/run_tests.py || die "Tests fail with ${EPYTHON}"
#}
