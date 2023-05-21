# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Implementation of per object permissions for Django"
HOMEPAGE="https://github.com/django-guardian/django-guardian"
SRC_URI="https://github.com/django-guardian/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		dev-python/django-environ[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme
