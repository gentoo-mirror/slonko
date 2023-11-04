# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Extends Django abilities beyond HTTP protocol"
HOMEPAGE="https://github.com/django/channels"
SRC_URI="https://github.com/django/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/asgiref-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/django-3.2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/async-timeout[${PYTHON_USEDEP}]
		>=dev-python/daphne-4.0.0[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
	)
"

DOCS=( README.rst )

distutils_enable_tests pytest
