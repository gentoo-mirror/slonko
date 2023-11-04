# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="HTTP, HTTP2 and WebSocket protocol server for ASGI and ASGI-HTTP"
HOMEPAGE="https://github.com/django/daphne"
SRC_URI="https://github.com/django/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/asgiref-3.5.2[${PYTHON_USEDEP}]
	<dev-python/asgiref-4.0[${PYTHON_USEDEP}]
	>=dev-python/autobahn-22.4.2[${PYTHON_USEDEP}]
	>=dev-python/django-3.2[${PYTHON_USEDEP}]
	>=dev-python/twisted-22.4[ssl,${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	)
"

DOCS=( README.rst )

distutils_enable_tests pytest

src_test() {
	ASGI_THREADS=4 distutils-r1_src_test
}
