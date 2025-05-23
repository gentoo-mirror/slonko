# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1 pypi

DESCRIPTION="Docker integration tests for pytest"
HOMEPAGE="
	https://github.com/Jc2k/pytest-docker-tools
	https://pypi.org/project/pytest-docker-tools/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/docker[${PYTHON_USEDEP}]"
