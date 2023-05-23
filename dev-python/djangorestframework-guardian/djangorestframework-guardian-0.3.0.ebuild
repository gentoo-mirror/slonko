# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="django-guardian support for Django REST Framework"
HOMEPAGE="
	https://github.com/rpkilby/django-rest-framework-guardian
	https://pypi.org/project/djangorestframework-guardian/
"
SRC_URI="https://github.com/rpkilby/django-rest-framework-guardian/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/django-rest-framework-guardian-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]
	dev-python/django-guardian[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

src_prepare() {
	# Django 4 compatibility
	sed -i -e 's/ugettext_lazy/gettext_lazy/g' tests/models.py

	distutils-r1_src_prepare
}

python_test() {
	"${EPYTHON}" manage.py test -v 2 tests || die
}
