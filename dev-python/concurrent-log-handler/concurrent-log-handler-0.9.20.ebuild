# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Python logging handler allowing safe concurrent write to the same log file"
HOMEPAGE="https://github.com/Preston-Landers/concurrent-log-handler"
SRC_URI="https://github.com/Preston-Landers/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/portalocker-1.4.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_test() {
	${EPYTHON} stresstest.py || die "Test failed"
}
