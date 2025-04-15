# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )
COMMIT="8163419b91d6b8c6ecb0c4edd30a0338f43db442"

inherit distutils-r1

DESCRIPTION="Soft delete models, managers, queryset for Django"
HOMEPAGE="https://github.com/san4ezy/django_softdelete"
SRC_URI="https://github.com/san4ezy/django_softdelete/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/django_softdelete-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		>=dev-python/pytest-django-4.5.2[${PYTHON_USEDEP}]
	)
"
distutils_enable_tests pytest

python_test() {
	local -x DJANGO_SETTINGS_MODULE=test_project.settings
	epytest --nomigrations
}
