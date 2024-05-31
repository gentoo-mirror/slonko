# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="A Python package to retrieve user's IP address"
HOMEPAGE="
	https://github.com/un33k/python-ipware
	https://pypi.org/project/python-ipware/
"
SRC_URI="https://github.com/un33k/python-ipware/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest
