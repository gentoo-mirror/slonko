# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

MY_P=${PN//-/_}-${PV}
DESCRIPTION="Celery Result Backends using the Django ORM/Cache framework."
HOMEPAGE="https://github.com/celery/django-celery-results"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-python/celery-5.2.3[${PYTHON_USEDEP}]
	<dev-python/celery-6.0[${PYTHON_USEDEP}]
	>=dev-python/django-3.2[${PYTHON_USEDEP}]
"

DOCS=( README.rst )

#BDEPEND="
#	test? (
#		>=dev-python/pytest-django-4.5.2[${PYTHON_USEDEP}]
#		dev-python/pytz[${PYTHON_USEDEP}]
#	)
#"
#
#distutils_enable_tests pytest
distutils_enable_sphinx doc
