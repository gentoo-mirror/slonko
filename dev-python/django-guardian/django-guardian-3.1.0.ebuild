# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="
	dev-python/mkdocs-material
	dev-python/mkdocs-material-extensions
	dev-python/mkdocstrings
	dev-python/mkdocstrings-python
"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 docs

DESCRIPTION="Implementation of per object permissions for Django"
HOMEPAGE="https://github.com/django-guardian/django-guardian"
SRC_URI="https://github.com/django-guardian/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

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
