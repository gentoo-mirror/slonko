# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} pypy3 )

inherit distutils-r1

DESCRIPTION="Python multiprocessing fork"
HOMEPAGE="https://github.com/celery/billiard"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

BDEPEND="
	test? (
		>=dev-python/psutil-5.9.0[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove Win32 test
	rm t/unit/test_win32.py || die

	# Get rid of dev-python/case dependency
	sed \
		-e 's/^from case \(.*\), skip$/from unittest.mock \1/' \
		-e '/^@skip/d' \
		-i t/unit/test_common.py

	distutils-r1_python_prepare_all
}
