# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
COMMIT="ca432d699bfa770fbb31e9d0780da0626dbbe7d3"

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
