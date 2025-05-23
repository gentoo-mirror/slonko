# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Python multiprocessing fork"
HOMEPAGE="https://github.com/celery/billiard"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

BDEPEND="
	test? (
		>=dev-python/psutil-5.9.0[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest
distutils_enable_sphinx Doc
