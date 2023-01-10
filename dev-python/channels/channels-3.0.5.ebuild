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
IUSE=""

DEPEND="
	>=dev-python/django-2.2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/async-timeout[${PYTHON_USEDEP}]
		>=dev-python/daphne-3.0[${PYTHON_USEDEP}]
		<dev-python/daphne-4.0[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
	)
"

DOCS=( README.rst )

distutils_enable_tests pytest

python_prepare_all() {
	# https://github.com/django/channels/issues/1915
	echo 'asyncio_mode = auto' >> setup.cfg

	distutils-r1_python_prepare_all
}
