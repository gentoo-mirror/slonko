# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..13} )

inherit distutils-r1

DESCRIPTION="Serve self-contained distribution builds of Swagger UI and Redoc with Django."
HOMEPAGE="https://github.com/tfranzel/drf-spectacular-seidecar"
SRC_URI="https://github.com/tfranzel/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/django-2.2[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
